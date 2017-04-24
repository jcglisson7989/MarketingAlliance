#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif
#include "../../paiComponents/Libraries/sprintf2/sprintf2.h"

/*
###############################################################################
Utilities
###############################################################################
*/

/**
 Simple logging
 Log goes to an array of PV strings > see _LOCAL STRING log[][] variable below
 Log output is visible via Automation Studio watch window
 Example of a log statement used within the code is: 
 DBG(lgr, "This is log example. %d ", value1);
 To complety disable logging from this source file, change next line to: #if 0
IMPORTANT:
==========
DBGINIT() statement MUST BE PLACED as a first statement within the task _INIT function!
Example:
void _INIT myTaskINIT(void)
{
	//TODO: Add code here
	//init logger object
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);
}
*/
#if 1
#include <../../paiComponents/bglib/bgPVLogger3.c>
#define LOG_ENTRY_COUNT 100	//max number of log entries
#define LOG_ENTRY_LENGTH  100 //max length of individual log message. Longer msg are truncated
_LOCAL STRING log[LOG_ENTRY_COUNT][LOG_ENTRY_LENGTH]; //log output visible from Automation Studio!
//static bgPVLogger_typ lgr;	//PV logger object
#else
#define DBG(loggerInstance, format, args...) ;
#define DBGINIT(loggerInstance, logoutput, logEntryCount, logEntrySize)  ;
#endif


//Color schemes used
#define COLOR_BACKGROUND	28 //for color index values and the asscoited color see B&R AS Help
#define COLOR_GRID	7 //for color index values and the asscoited color see B&R AS Help
#define COLOR_X_CAM 201
#define COLOR_Z_CAM 21
#define COLOR_XZ_FWD_MOVE 221
#define COLOR_XZ_REV_MOVE 51
#define COLOR_XZ_TEXT_PICK 63
#define COLOR_XZ_TEXT_DROP 129

#define FONT_CAM_GRAPH 1

#define APP_SCALE_PIXEL_PER_INCH 7

#define APP_CASE_CMD_NONE 0
#define APP_CASE_CMD_CASE 1
#define APP_CASE_CMD_CASE_plus90 2
#define APP_CASE_CMD_BLADE1 3
#define APP_CASE_CMD_EVENT1 4

#define COLOR_INDEX_CMDS_YELLOW 0
#define COLOR_INDEX_CMDS_GREEN 1
#define COLOR_INDEX_CMDS_RED 2


#if 0
#define CAM_START_END_RANGE	20 //Minimum difference (%) between starting and ending point of the CAM move (forward or reverse)
#define CAM_CALC_ERRORSTATE 100 //Error state for CAM calculation state machine
#endif


#define DRWSTATE_NOTREADY 	 0
#define DRWSTATE_IDLE 			 1
#define DRWSTATE_INIT 			 2
#define DRWSTATE_CLRALL 		 3
#define DRWSTATE_GRID 			 4
#define DRWSTATE_DRAWDATASET 5
#define DRWSTATE_DRAWXZ 		 6
#define DRWSTATE_TEXTOUT 		 7
#define DRWSTATE_RECT 		    8
#define DRWSTATE_BOXLAYER 		    9

#if 0
#define CAMCALCCMD_IDLE 	0
#define CAMCALCCMD_CREATE 	1
#define CAMCALCCMD_SLAVEPOS 2
#endif
//#include "camcalc.h"

#define DATASET_SIZE 200


/*
===============================================================================
Callback routines for simplfiying statemachine handling
===============================================================================
*/
#define CB_INC	255
static void cbSetCallback(paCallback_typ* p, UDINT* pCallback, UDINT callback)
{
	p->pCallback = pCallback;
	p->callbackValue = callback;
	p->callbackRet = 1; //processing complete
	p->callbackState = 0;
}

static void cbFireCallback(paCallback_typ* p)
{
	if(p->callbackValue == CB_INC)
		(*p->pCallback)++;
	else
		(*p->pCallback) = p->callbackValue;
}


/*
===============================================================================
Drawing routines and cyclic service
===============================================================================
*/

/*
Main drawing routine. Encapsulates all drawing related calls and follows the rulses of VISAPI access to screen resources.
*/
static BOOL drwDraw(paDrawBoxDrawing_typ* p, void(*pFun)(paDrawBoxDrawing_typ* p) )
{
	BOOL ret = 0; //drawing NOT completed

	//make sure that visualization handle is retrived
	if(!p->ctrl.handle){
		p->ctrl.handle = VA_Setup(1, p->ctrl.nameVisu);		
		if(!p->ctrl.handle)
			return ret;
	}
	
	//grab visapi access semaphor
	if (VA_Saccess(1, p->ctrl.handle))
		return ret;
			
	//attach to draw box control
	if (!VA_Attach(1, p->ctrl.handle, 0, (UDINT)p->ctrl.nameDrawBoxCtrl)){		
		
		//call a specific drawing routine
		if(pFun){
			(*pFun)(p);
		}

		ret = p->cb.callbackRet; //drawing completed status; 1-Done; 0-Not Done, call it again

		//deattach from draw box control
		VA_Detach(1, p->ctrl.handle);				
	}

	VA_Srelease(1, p->ctrl.handle);
	return ret;
}




/*
Retrive size (pixels) of the Drawbox control. 
*/
static void drwDrawGetCtrlSize(paDrawBoxDrawing_typ* p)
{
	/* Get width of DrawBox Control*/
	VA_GetDisplayInfo(1, p->ctrl.handle, 1, (UDINT)&p->ctrl.width);

	/* Get height of DrawBox Control */ 
	VA_GetDisplayInfo(1, p->ctrl.handle, 2, (UDINT)&p->ctrl.height);
}


/*
Clear Drawbox control. 
*/
static void drwDrawClearAll(paDrawBoxDrawing_typ* p)
{
	VA_Redraw (1, p->ctrl.handle);
	
	VA_Rect (1, p->ctrl.handle, 0, 0, p->ctrl.width, p->ctrl.height,  p->ctrl.colorIndex, p->ctrl.colorIndex);		
}


/*
Draw text. 
*/
static void drwDrawTextout(paDrawBoxDrawing_typ* p)
{
	VA_Textout (p->textout.iEnable, p->ctrl.handle, p->textout.iFontIndex, p->textout.iX, p->textout.iY, p->textout.iFColorIndex, p->textout.iBColorIndex, p->textout.iText);
}

/*
Draw text. 
*/
static void drwDrawRect(paDrawBoxDrawing_typ* p)
{
	VA_Rect (p->rect.iEnable, p->ctrl.handle, p->rect.iX, p->rect.iY, p->rect.iWidth, p->rect.iHeight, p->rect.iFillColorIndex, p->rect.iBorderColorIndex);
}

/*
Draw grid.
*/
static void drwDrawGrid(paDrawBoxDrawing_typ* p)
{
	UINT x, y, dx, dy; 
	int ii;

	dx = p->ctrl.width / (p->grid.ivLineCount);
	dy = p->ctrl.height/ (p->grid.ihLineCount);
	
	x = dx;
	y = p->ctrl.height - dy;

	//horizontal grid lines
	for(ii=0;ii<p->grid.ihLineCount;ii++){	
		VA_Line(1, p->ctrl.handle, 0, y,  p->ctrl.width, y, p->grid.ihColorIndex);

		//support for thicker (i.e. divider) lines
		if(p->grid.ihThickRepeat){
			if( !((ii+1)%p->grid.ihThickRepeat) ){
				VA_Line(1, p->ctrl.handle, 0, y+1,  p->ctrl.width, y+1, p->grid.ihColorIndex);
			}
		}

		
		y -= dy;
	}
	
	//vertical grid lines
	for(ii=0;ii<p->grid.ivLineCount;ii++){	
		VA_Line(1, p->ctrl.handle, x, 0,  x, p->ctrl.height, p->grid.ivColorIndex);

		//support for thicker (i.e. divider) lines
		if(p->grid.ivThickRepeat){
			if( !((ii+1)%p->grid.ivThickRepeat) ){
				VA_Line(1, p->ctrl.handle, x+1, 0,  x+1, p->ctrl.height, p->grid.ivColorIndex);
			}
		}

		
		x += dx;
	}					

}


/*
y = kx;
k = (y2 - y1)/(x2 - x1)
*/
static REAL scaleValue(REAL x, REAL xMax, REAL xMin, REAL yMax, REAL yMin)
{

	REAL k = (yMax - yMin ) / (xMax - xMin);
	return (	x * k );
}



/*
Draw graph of a supplied dataset.
- Dataset is given as an array of values
- Dataset has a size associted with it (number of elemets in the array)
- Drawing routine does following:
---x values of the graph index values of the dataset array. Range is from 0..datasetSize-1. 
---x axis is either streched or squizzed depedning on the scaling ratio. Scaling ratio is a ratio between number of horizontal pixels on the graph and 
     the number of elemenens in the dataset
---y values of the graph are values found in the dataset array (i.e. y=f(x)). Input parametars yMax and yMin are used for streching the graph verticaly.
---y axis is either streched or squizzed depedning on the scaling ratio. Scaling ratio is a ratio between the dataset range (yMax - yMin) and numberr of vertical pixels on the graph
*/
static void drwDrawDataset(paDrawBoxDrawing_typ* p)
{
	//NOTE: function does horizontal and vertical fitting (streching) of the supplied dataset to the available graph area

	int ii;
	int jj;
	UINT xMaxGraph, yMaxGraph; //graph size (in pixels which a units as well)

	UDINT idx_ii;	
	UDINT idx_ii_1; 
	
	REAL datasetVal_ii;
	REAL datasetVal_ii_1;
	
	UDINT yGraph_ii;
	UDINT yGraph_ii_1;

	switch(p->cb.callbackState){
		case 0://init state
			p->cb.callbackParams[0] = 0;//starting point for the following loop; set to 0 on initial state
			DBG(lgr, "xORz beg =%d", p->cb.callbackParams[0]);
			break;
		case 1:
			DBG(lgr, "xORz res =%d", p->cb.callbackParams[0]);
			//starting point for the following loop; untouched on subequent calls (keeps track of where we stopped last time)
			break;
	}


	//obtain graph size
	xMaxGraph = p->ctrl.width;
	yMaxGraph = p->ctrl.height;

	//100% horizontal strech > entire x range of dataset will be displayed within the entire x graph range
	//for(ii=0;ii<(xMaxGraph-1);ii++){	
	for(ii=p->cb.callbackParams[0], jj=0;ii<(xMaxGraph-1);ii++, jj++){	
		UINT retDrw;
		
		idx_ii = (UDINT) scaleValue(ii,  xMaxGraph, 0, p->data1.iSizeDataset, 0); //calculate dataset index for the i-th point on the graph
		idx_ii_1 = (UDINT) scaleValue(ii + 1,  xMaxGraph, 0, p->data1.iSizeDataset, 0); //calculate dataset index for the (i+1)-th point on the graph


		datasetVal_ii = p->data1.ipDataset[idx_ii]; //retrive dataset value for the i-tx horizontal point on the graph
		datasetVal_ii_1 = p->data1.ipDataset[idx_ii_1];//retrive dataset value for the (i+1)-tx horizontal point on the graph


		yGraph_ii = scaleValue(datasetVal_ii, p->data1.iMaxValue, p->data1.iMinValue, yMaxGraph, 0);//calculate vertical graph point for the i-th horizontal point on the graph
		yGraph_ii_1 = scaleValue(datasetVal_ii_1, p->data1.iMaxValue, p->data1.iMinValue, yMaxGraph, 0);//calculate vertical graph point for the (i+1)-th horizontal point on the graph


		//for better graph visibilty, fudge min and max y values (0,  yMaxGraph) 
		if(!yGraph_ii)
			yGraph_ii=1;
		
		if(yGraph_ii>=yMaxGraph)
			yGraph_ii=yMaxGraph-1;

		if( jj>=200 ){
			p->cb.callbackRet = 0; //NOT done; will come back to execute this same function
			p->cb.callbackState = 1;
			p->cb.callbackParams[0] = ii; //remeber item where we stopped
			DBG(lgr, "xORz exit 200 =%d", ii);
			return;
		}
		
		//draw consecutive line segements
		retDrw = VA_Line(1, p->ctrl.handle, ii, yMaxGraph - (UDINT)yGraph_ii,  ii+1, yMaxGraph - (UDINT)yGraph_ii_1, p->data1.iColorIndex);
		if( retDrw ){
			p->cb.callbackRet = 0; //NOT done; will come back to execute this same function
			p->cb.callbackState = 1;
			p->cb.callbackParams[0] = ii; //remeber item where we stopped
			DBG(lgr, "xORz exit=%d (%d)", ii, retDrw );
			return;
		}

		
	}

	drwDrawTextout(p);
	p->textout.iEnable=0;

	p->cb.callbackRet = 1; //done
}

_LOCAL UDINT gbGraphRotate;

static void drwDrawLayer(paDrawBoxDrawing_typ* p)
{
	//NOTE: function does horizontal and vertical fitting (streching) of the supplied dataset to the available graph area

	int ii;
	int jj;
	UINT xMaxGraph, yMaxGraph; //graph size (in pixels which a units as well)
	UDINT x;
	UDINT y;
	UDINT w;
	UDINT h;

	

	switch(p->cb.callbackState){
		case 0://init state
			p->cb.callbackParams[0] = 0;//starting point for the following loop; set to 0 on initial state
			DBG(lgr, "boxLayer beg =%d", p->cb.callbackParams[0]);
			break;
		case 1:
			DBG(lgr, "boxLayer res =%d", p->cb.callbackParams[0]);
			//starting point for the following loop; untouched on subequent calls (keeps track of where we stopped last time)
			break;
	}


	//obtain graph size
	xMaxGraph = p->ctrl.width;
	yMaxGraph = p->ctrl.height;

	//for(ii=0;ii<(xMaxGraph-1);ii++){	
	for( ii=p->cb.callbackParams[0], jj=0; ii<=PADRAW_RECT_MAXIDX; ii++, jj++){	
		UINT retDrw;
		char txtBuf[32];
		
		if(!p->pRectArray[ii].iEnable)
			continue;
		
		//TODO: improve following
		if(gConfigApp.system.boxInfeedSide == 0){
			gbGraphRotate = 1;
		}else{
			gbGraphRotate = 2;		
		}
		
		//draw rectangles
		if(gbGraphRotate == 0){//native layout; pusher from the left to right of the screen; infeed from bottom to top
			x = p->pRectArray[ii].iX;
			y = p->pRectArray[ii].iY;
			w = p->pRectArray[ii].iWidth;
			h = p->pRectArray[ii].iHeight;
		}else
		if(gbGraphRotate == 1){//pusher from the bottom of the screen; infeed boxes from the right to the left of the screen
			x = p->pRectArray[ii].iY;//p->pRectArray[ii].iX;
			y = yMaxGraph - p->pRectArray[ii].iX - p->pRectArray[ii].iWidth;//p->pRectArray[ii].iY;
			w = p->pRectArray[ii].iHeight;//p->pRectArray[ii].iWidth;
			h = p->pRectArray[ii].iWidth;//p->pRectArray[ii].iHeight;
		}else
		if(gbGraphRotate == 2){//pusher from the bottom of the screen; infeed boxes from the left to the right of the screen
			x = xMaxGraph - p->pRectArray[ii].iY - p->pRectArray[ii].iHeight;//p->pRectArray[ii].iX;
			y = yMaxGraph - p->pRectArray[ii].iX - p->pRectArray[ii].iWidth;//p->pRectArray[ii].iY;
			w = p->pRectArray[ii].iHeight;//p->pRectArray[ii].iWidth;
			h = p->pRectArray[ii].iWidth;//p->pRectArray[ii].iHeight;
		}
		
		//retDrw = VA_Rect (1, p->ctrl.handle, p->pRectArray[ii].iX , p->pRectArray[ii].iY, p->pRectArray[ii].iWidth, p->pRectArray[ii].iHeight, p->pRectArray[ii].iFillColorIndex, p->pRectArray[ii].iBorderColorIndex);
		retDrw = VA_Rect (1, p->ctrl.handle, x , y, w, h, p->pRectArray[ii].iFillColorIndex, p->pRectArray[ii].iBorderColorIndex);
		
		if( retDrw ){
			p->cb.callbackRet = 0; //NOT done; will come back to execute this same function
			p->cb.callbackState = 1;
			p->cb.callbackParams[0] = ii; //remeber item where we stopped
			DBG(lgr, "boxLayer exit0=%d (%d)", ii, retDrw );
			return;
		}
		
		brsitoa(ii, (UDINT)txtBuf);
		//retDrw = VA_Textout (1, p->ctrl.handle, 0, p->pRectArray[ii].iX + 10, p->pRectArray[ii].iY + 10, 0, 15, txtBuf);
		retDrw = VA_Textout (1, p->ctrl.handle, 0, x + 10, y + 10, 0, 15, txtBuf);
						
		if( retDrw ){
			p->cb.callbackRet = 0; //NOT done; will come back to execute this same function
			p->cb.callbackState = 1;
			p->cb.callbackParams[0] = ii; //remeber item where we stopped
			DBG(lgr, "boxLayer exit1=%d (%d)", ii, retDrw );
			return;
		}

		
	}

	p->textout.iEnable=0;
	p->cb.callbackRet = 1; //done
}

/*
Access routines to the drawing cyclic service.
*/
static void cmdConfigureDraw(paDrawBoxDrawing_typ* p, char* nameVisu, char* nameDrawbox, USINT bgColorIdx, USINT gridHlines, USINT gridVLines, USINT gridHColorIdx, USINT gridVColorIdx,
	USINT gridHThickRepeat, USINT gridVThickRepeat)
{
	if(!nameVisu || !nameDrawbox)
		return;
	
	brsstrcpy((UDINT)p->ctrl.nameVisu, (UDINT)nameVisu);
	brsstrcpy((UDINT)p->ctrl.nameDrawBoxCtrl, (UDINT)nameDrawbox);
	p->ctrl.colorIndex = bgColorIdx;

	p->grid.ivLineCount = gridVLines;
	p->grid.ihLineCount = gridHlines;
	p->grid.ivThickRepeat = gridVThickRepeat;
	p->grid.ihThickRepeat = gridHThickRepeat;
	p->grid.ivColorIndex= gridVColorIdx;
	p->grid.ihColorIndex= gridHColorIdx;	
	
	p->ctrl.state = DRWSTATE_IDLE;;	
}

static void cmdConfigureTextout(paDrawBoxDrawing_typ* p, BOOL enable, USINT fontIndex, USINT x, USINT y, USINT fcIndex, USINT bcIndex, char* text)
{
	p->textout.iEnable=enable;
	p->textout.iFontIndex=fontIndex;
	p->textout.iX=x;
	p->textout.iY=y;
	p->textout.iFColorIndex=fcIndex;
	p->textout.iBColorIndex=bcIndex;
	brsstrcpy((UDINT)p->textout.iText, (UDINT)text);
}

static void cmdDrawTextout(paDrawBoxDrawing_typ* p, USINT fontIndex, USINT x, USINT y, USINT fcIndex, USINT bcIndex, char* text, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		cmdConfigureTextout(p, 1, fontIndex, x, y, fcIndex, bcIndex, text);
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_TEXTOUT;
	}
}

static void cmdDrawRect(paDrawBoxDrawing_typ* p, UINT x, UINT y, UINT h, UINT w, USINT fcIndex, USINT bcIndex, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		//cmdConfigureTextout(p, 1, fontIndex, x, y, fcIndex, bcIndex, text);
		p->rect.iEnable = 1;
		p->rect.iX = x;
		p->rect.iY = y;
		p->rect.iWidth = w;
		p->rect.iHeight = h;
		p->rect.iFillColorIndex = fcIndex;
		p->rect.iBorderColorIndex = bcIndex;
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_RECT;
	}
}


static void cmdDrawInit(paDrawBoxDrawing_typ* p, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_INIT;
	}		
}

static void cmdDrawClrAll(paDrawBoxDrawing_typ* p, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_CLRALL;
	}
}

static void cmdDrawGrid(paDrawBoxDrawing_typ* p, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_GRID;
	}
}
#if 0
static void cmdDrawDrawDataset(paDrawBoxDrawing_typ* p, REAL* pDataset, UDINT sizeDataset, REAL datasetMin, REAL datasetMax, UINT colorIdx, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		//dataset scaling range
		p->data1.iMaxValue = datasetMax;
		p->data1.iMinValue = datasetMin;
		
		//dataset to draw
		p->data1.ipDataset = pDataset;
		p->data1.iSizeDataset = sizeDataset;

		//color
		p->data1.iColorIndex = colorIdx;
		
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_DRAWDATASET;
	}
}
#endif
static void cmdDrawBoxLayer(paDrawBoxDrawing_typ* p, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		//dataset scaling range		
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_BOXLAYER;
	}
}

#if 0
static void setCamForDrawingXZ(paDrawBoxDrawing_typ* p, paCamCalc_typ* pXCam, paCamCalc_typ* pZCam)
{
	p->xzProfile.ixCamDataset.iMaxValue = 1.0;
	p->xzProfile.ixCamDataset.iMinValue = 0.0;
	p->xzProfile.ixCamDataset.ipDataset = pXCam->camProfile.pDataset;
	p->xzProfile.ixCamDataset.iSizeDataset = pXCam->camProfile.sizeDataset;
	
	p->xzProfile.izCamDataset.iMaxValue = 1.0;
	p->xzProfile.izCamDataset.iMinValue = 0.0;
	p->xzProfile.izCamDataset.ipDataset = pZCam->camProfile.pDataset;
	p->xzProfile.izCamDataset.iSizeDataset = pZCam->camProfile.sizeDataset;
}

static void cmdDrawCfgXZGraphPick(paDrawBoxDrawing_typ* p, REAL xPick, REAL zPick)
{
	p->xzProfile.ixPick= xPick;
	p->xzProfile.izPick= zPick;
}

static void cmdDrawCfgXZGraphDrop(paDrawBoxDrawing_typ* p, REAL xDrop, REAL zDrop)
{
	p->xzProfile.ixDrop = xDrop;
	p->xzProfile.izDrop = zDrop;
}

static void cmdDrawCfgXZGraph(paDrawBoxDrawing_typ* p, REAL xPick, REAL zPick, REAL xDrop, REAL zDrop, REAL xPhyRange, REAL zPhyRange, USINT fwdClrIdx, USINT revClrIdx)
{

	cmdDrawCfgXZGraphPick(p, xPick, zPick);
	cmdDrawCfgXZGraphDrop(p, xDrop, zDrop);
	p->xzProfile.ixPhysicalRange = xPhyRange;
	p->xzProfile.izPhysicalRange = zPhyRange;
	p->xzProfile.iFwdClrIdx = fwdClrIdx;
	p->xzProfile.iRevClrIdx = revClrIdx;
	
}

static void cmdDrawDrawXZMotionProfile(paDrawBoxDrawing_typ* p, paCamCalc_typ* pXCam, paCamCalc_typ* pZCam, UDINT* pState, UDINT nextState)
{
	if(p->ctrl.state == DRWSTATE_IDLE){
		setCamForDrawingXZ(p, pXCam, pZCam);		
		cbSetCallback(&p->cb, pState, nextState);
		p->ctrl.state = DRWSTATE_DRAWXZ;
	}
}

#endif

/*
Drawing cyclic service state machine.
*/
static void drwCamEditCyclic(paDrawBoxDrawing_typ* p)
{
	switch(p->ctrl.state){
		case DRWSTATE_NOTREADY:
			
			break;
		case DRWSTATE_IDLE:
			
			break;
		case DRWSTATE_INIT:
			if( drwDraw(p, drwDrawGetCtrlSize) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}
			break;
		case DRWSTATE_CLRALL:
			if( drwDraw(p, drwDrawClearAll) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}
			break;
		case DRWSTATE_GRID:
			if( drwDraw(p, drwDrawGrid) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}
			break;
		case DRWSTATE_DRAWDATASET:
			if( drwDraw(p, drwDrawDataset) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}				
			break;
		case DRWSTATE_TEXTOUT:
			if( drwDraw(p, drwDrawTextout) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}
			break;
		case DRWSTATE_RECT:
			if( drwDraw(p, drwDrawRect) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}
			break;
		
		case DRWSTATE_BOXLAYER:
			if( drwDraw(p, drwDrawLayer) ){
				cbFireCallback(&p->cb);
				p->ctrl.state = DRWSTATE_IDLE;			
			}			
			break;	
		default:
			break;

	}
}
/*
===============================================================================


===============================================================================
*/

enum appSteps{
	appStepIdle = 0,
	appStepCAMViewActive,
	appStepCAMCreateWait,
	appStepCAMDrawWait,
	appStepXZDrawWait,
	

	appStepCfgCAMs = 10,
	appStepXCamCreate,
	appStepXCamCreateWait,
	appStepXCamSPos,
	appStepXCamSPosWait,
	appStepZCamCreate,
	appStepZCamCreateWait,
	appStepZCamSPos,
	appStepZCamSPosWait,


	appStepDrwInit = 20,
	appStepDrwClr,
	appStepDrwGrid,
	appStepDrwX,
	appStepDrwZ,
	
	appStepDrwBoxInit=30,
	appStepDrwBox1=31,

	appStepClrCAM=50,
	appStepClrCAM1,
	appStepClrXZ,
	appStepClrXZ1,

};

#if 0
static REAL convertMilsToInch(REAL mils)
{
	return (mils / 1000.0);
}
#endif

static void myApp()
{

	if(gPaiHmiMain.runtime.pageCurrent != 41){
		gCamApp.state = appStepIdle;
		return;
	}
	
	switch(gCamApp.state){
		//==========================================================
		case appStepIdle:	
			
			if(gPaiHmiMain.runtime.pageCurrent != 41){
				return;
			}
			//screen getting activated
			gCamApp.state = appStepDrwInit;	//calculate current CAM-s to display! 
			//Note here that step after cam calculation is going to be appStepCAMCreateWait
			break;					
		
		//==========================================================
		case appStepDrwInit:
			cmdDrawInit(&gDrawBoxLayer, &gCamApp.state, CB_INC);
			break;	
		case appStepDrwClr:
			cmdDrawClrAll(&gDrawBoxLayer, &gCamApp.state, CB_INC);
			break;	
		case appStepDrwGrid:
			//cmdDrawGrid(&gDrawBoxLayer, &gCamApp.state, CB_INC);
			cmdDrawGrid(&gDrawBoxLayer, &gCamApp.state, appStepDrwBox1);
			break;	
		case appStepDrwX:
			//DBG("appStepDrwX");
			//cmdConfigureTextout(&gDrawBoxLayer, 1, FONT_CAM_GRAPH, 12, 20, COLOR_X_CAM, COLOR_BACKGROUND, "H-CAM");
			cmdDrawTextout(&gDrawBoxLayer, FONT_CAM_GRAPH, 12, 20, COLOR_X_CAM, COLOR_BACKGROUND, "H-CAM", &gCamApp.state, CB_INC);
			//cmdDrawDrawDataset(&gDrawBoxLayer, gCamCalcX.camProfile.pDataset, gCamCalcX.camProfile.sizeDataset, 0.0, 1.0, COLOR_X_CAM, &gCamApp.state, CB_INC);
			break;	
		case appStepDrwZ:
			//DBG("appStepDrwZ");
			//cmdConfigureTextout(&gDrawBoxLayer, 1, FONT_CAM_GRAPH, 12, 40, COLOR_Z_CAM, COLOR_BACKGROUND, "V-CAM");
			cmdDrawTextout(&gDrawBoxLayer, FONT_CAM_GRAPH, 12, 40, COLOR_Z_CAM, COLOR_BACKGROUND, "V-CAM", &gCamApp.state, appStepDrwBoxInit);
			//cmdDrawDrawDataset(&gDrawBoxLayer, gCamCalcZ.camProfile.pDataset, gCamCalcZ.camProfile.sizeDataset, 0.0, 1.0, COLOR_Z_CAM, &gCamApp.state, appStepCAMDrawWait);
			break;	

		case appStepDrwBoxInit:
		
			cmdDrawRect(&gDrawBoxLayer, 100, 100, 80, 160, 5, 14, &gCamApp.state, CB_INC);		
			
			
		break;	
		case appStepDrwBox1:
		
			cmdDrawBoxLayer(&gDrawBoxLayer, &gCamApp.state, CB_INC);		
						
			break;	
		
		default:
			break;
	}
	
}

#define PADRAW_CLR_1 6
#define PADRAW_CLR_2 10
#define PADRAW_BOX_W 40
#define PADRAW_BOX_L 60

static int checkIfThisPushingOther(int thisX, int thisY, int thisLn, int thisWd, int otherX, int otherY, int otherLn, int otherWd ){
int touchingLn;
int pushDistance;
	
	DBG(lgr, "chkpsh:(%d:%d,%d:%d)->(%d:%d,%d:%d)", thisX, thisY, thisLn, thisWd, otherX, otherY, otherLn, otherWd);
	
	if( (thisY + thisLn) < otherY )
		return 0;
	
	if( thisY > (otherY + otherLn) )
		return 0;
	
	if((thisX + thisWd) <= otherX)
		return 0;
	
	if( (thisY + thisLn) > (otherY + otherLn) ){
		if(thisY > otherY){
			touchingLn = (thisY + thisLn) - otherY;		
		}else{
			touchingLn = thisLn;		
		}
	}else{
		if(thisY > otherY){
			touchingLn = (otherY + otherLn) - thisY;		
		}else{
			touchingLn = otherLn;		
		}
	}
	
	if( (thisX + thisWd) > otherX){
		pushDistance = thisX + thisWd - otherX;
	}else{
		pushDistance = 0;	
	}
	
	
	return pushDistance;
}

static void pushBoxes(int kk)
{
	int ii;
	
	int thisX;
	int thisY;
	int thisWd;
	int thisLn;
	
	int otherX;
	int otherY;
	int otherWd;
	int otherLn;
	
	if(!kk)
		return;

//	DBG(lgr, "push box=%d", kk);
	
	thisX = gDrawRect[kk].iX;
	thisY = gDrawRect[kk].iY;				
	thisLn = gDrawRect[kk].iHeight;
	thisWd = gDrawRect[kk].iWidth;
	
	for(ii=kk-1; ii >= 0; ii--){
		int pushDistance;
		
//		DBG(lgr, "push box other=%d", ii);
		
		otherX = gDrawRect[ii].iX;
		otherY = gDrawRect[ii].iY;				
		otherLn = gDrawRect[ii].iHeight;
		otherWd = gDrawRect[ii].iWidth;
		
		pushDistance = checkIfThisPushingOther(thisX, thisY, thisLn, thisWd, otherX, otherY, otherLn, otherWd);
		
		if( pushDistance > 0 ){
			gDrawRect[ii].iX += pushDistance;
			DBG(lgr, "box=%d pushes box=%d dist=%d", kk, ii, pushDistance);
			pushBoxes(ii);//recursive call
		}		
	}	

}

static void	appDefineBoxLayer()
{
	int ii;
	int jj;
	int kk;
	int x;
	int y;
	int dy = 1;
#if 0	
	gTestLayer[0].animationRow[0] = 1;
	gTestLayer[0].animationRow[1] = 1;
	gTestLayer[0].animationRow[2] = 2;
	gTestLayer[0].animationRow[3] = 0;
	
	gTestLayer[1].animationRow[0] = 1;
//	gTestLayer[1].animationRow[1] = 0;
	gTestLayer[1].animationRow[1] = 2;
	gTestLayer[1].animationRow[2] = 1;
	gTestLayer[1].animationRow[3] = 0;
	
//	gTestLayer[2].animationRow[0] = 0;
	gTestLayer[2].animationRow[0] = 2;
	gTestLayer[2].animationRow[1] = 1;
	gTestLayer[2].animationRow[2] = 1;
	gTestLayer[2].animationRow[3] = 0;
	
	gTestLayer[3].animationRow[0] = 0;
#endif
	
	kk = 0;
	x = 0;
	y = 0;
	
	//disable all rects
	for(ii=0; ii<=PADRAW_RECT_MAXIDX; ii++){	
		gDrawRect[ii].iEnable = 0;
	}
	
	
	//redefine all rects
	for(ii=0; ii<10; ii++){	
	
		if(gTestLayer[ii].animationRow[0] == 0){
			break;
		}
		
		for(jj=0; jj<10;jj++){
			
			if(gTestLayer[ii].animationRow[jj] == 0){
				y = 0;
				break;
			}
			
			gDrawRect[kk].iEnable = 1;
			gDrawRect[kk].iX = x;
			gDrawRect[kk].iY = y;
		
/*			
#define APP_CASE_CMD_NONE 0
#define APP_CASE_CMD_CASE 1
#define APP_CASE_CMD_CASE_plus90 2
#define APP_CASE_CMD_BLADE1 3
#define APP_CASE_CMD_EVENT1 4
*/

			
			if(gTestLayer[ii].animationRow[jj] == APP_CASE_CMD_CASE){
				gDrawRect[kk].iHeight = gBoxSize.length_pixel;
				gDrawRect[kk].iWidth = gBoxSize.width_pixel;
				gDrawRect[kk].iFillColorIndex = PADRAW_CLR_2;
				gDrawRect[kk].iBorderColorIndex = PADRAW_CLR_1;			
			}else{
				gDrawRect[kk].iHeight = gBoxSize.width_pixel;
				gDrawRect[kk].iWidth = gBoxSize.length_pixel;
				gDrawRect[kk].iFillColorIndex = PADRAW_CLR_1;
				gDrawRect[kk].iBorderColorIndex = PADRAW_CLR_2;
			}	
			y += (gDrawRect[kk].iHeight + dy);
			
			DBG(lgr, "add box=%d", kk);
			pushBoxes(kk);
			
			kk++;
		}
			
	}
	
}


static void	appDefineBoxLayerNew()
{
	int ii;
	int jj;
	int kk;
	int x;
	int y;
	int dy = 1;
	
	kk = 0;
	x = 0;
	y = 0;
	int y_blade = 0;
	int y_blade_pixel = 0;
	
	//disable all rects
	for(ii=0; ii<=PADRAW_RECT_MAXIDX; ii++){	
		gDrawRect[ii].iEnable = 0;
	}
	
	
	//redefine all rects
	for(ii=0; ii<10; ii++){	
		
	
		//if(gTestLayer[ii].animationRow[0] == 0){
		//	break;
		//}
		if( gLayerEditor.palCfgRows[ii].palCfgCmds[0].cmdCase == 0){
			break;
		}

		
		for(jj=0; jj<10;jj++){
			
			//if(gTestLayer[ii].animationRow[jj] == 0){
			//	y = 0;
			//	break;
			//}
			if(gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdCase == 0){
				y = 0;
				break;
			}
			
			//added support for blade stops
			//this is NATIVE coordinate system; see above!!!
			y_blade = 0;
			if( (gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdBlade > 0) && ((gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdBlade <= 6))){
				y_blade = gConfigApp.system.bladeStopDistance[gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdBlade - 1];
				y_blade_pixel = y_blade * APP_SCALE_PIXEL_PER_INCH;
				if(y < y_blade_pixel){
					y = y_blade_pixel;
					DBG(lgr, "add box=%d w. blade=%d, pos=%d[\"]", kk, gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdBlade, (UDINT)y_blade);
				}else{
					DBG(lgr, "add box=%d ERR! blade=%d, pos=%d[\"]", kk, gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdBlade, (UDINT)y_blade);
					gLayerEditorTxt.palCfgRowsTxt[ii].palCfgCmdsTxt[jj].colorIdx = COLOR_INDEX_CMDS_RED;//red > error
				}
			}
			
			gDrawRect[kk].iEnable = 1;
			gDrawRect[kk].iX = x;
			gDrawRect[kk].iY = y;
		
/*			
#define APP_CASE_CMD_NONE 0
#define APP_CASE_CMD_CASE 1
#define APP_CASE_CMD_CASE_plus90 2
#define APP_CASE_CMD_BLADE1 3
#define APP_CASE_CMD_EVENT1 4
*/

			
//			if(gTestLayer[ii].animationRow[jj] == APP_CASE_CMD_CASE){
			if(gLayerEditor.palCfgRows[ii].palCfgCmds[jj].cmdCase == 1){
				gDrawRect[kk].iHeight = gBoxSize.length_pixel;
				gDrawRect[kk].iWidth = gBoxSize.width_pixel;
				gDrawRect[kk].iFillColorIndex = PADRAW_CLR_2;
				gDrawRect[kk].iBorderColorIndex = PADRAW_CLR_1;			
			}else{
				gDrawRect[kk].iHeight = gBoxSize.width_pixel;
				gDrawRect[kk].iWidth = gBoxSize.length_pixel;
				gDrawRect[kk].iFillColorIndex = PADRAW_CLR_1;
				gDrawRect[kk].iBorderColorIndex = PADRAW_CLR_2;
			}	
			y += (gDrawRect[kk].iHeight + dy);
			
			DBG(lgr, "add box=%d", kk);
			pushBoxes(kk);
			
			kk++;
		}
			
	}
	
}


/*
###############################################################################
Init, Cyclic, Exit
###############################################################################
*/
void _INIT appDrawInit(void)
{
	DBGINIT(lgr, log, LOG_ENTRY_COUNT, LOG_ENTRY_LENGTH);

	/* TODO: Add code here */
	
	if(gBoxSize.height_inch < 0.1){
		gBoxSize.height_inch = 10.0;
	}
	if(!gBoxSize.width_inch < 0.1){
		gBoxSize.width_inch = 12.0;
	}
	if(!gBoxSize.length_inch < 0.1){
		gBoxSize.length_inch = 18.0;	
	}


	gDrawBoxLayer.pRectArray = &gDrawRect[0];
	cmdConfigureDraw(&gDrawBoxLayer, "WSVGA", "tmpl41_LayerPreview/Default/DrawBox_1", COLOR_BACKGROUND, 50, 50, COLOR_GRID, COLOR_GRID, 10, 10);
//	cmdConfigureDraw(&gXZDisplay, "Panel", "P32_CASE_SETCAM/Default/DrawBox_XZ", COLOR_BACKGROUND, 30, 30, COLOR_GRID, COLOR_GRID, 10, 10);

	DBG(lgr, "cam edit");
}

void _CYCLIC appDrawCyclic(void)
{
	/* TODO: Add code here */

	//Drawing cyclic service
	drwCamEditCyclic(&gDrawBoxLayer);

	//Drawing cyclic service
	//drwCamEditCyclic(&gXZDisplay, &gCamCalcX, &gCamCalcZ);


	//CAM Viewing/Drawing application
	myApp();		
	
	if(gCamApp.btnPreview || gCtrl.main.gCamApp_btnPreview){
		gCamApp.btnPreview = 0;
		gCtrl.main.gCamApp_btnPreview = 0;
		
		//gBoxSize.height_pixel = (UDINT)(gBoxSize.height_inch * APP_SCALE_PIXEL_PER_INCH);
		//gBoxSize.width_pixel = (UDINT)(gBoxSize.width_inch * APP_SCALE_PIXEL_PER_INCH);
		//gBoxSize.length_pixel = (UDINT)(gBoxSize.length_inch * APP_SCALE_PIXEL_PER_INCH);
		gBoxSize.height_pixel = (UDINT)(gPallete.palCfg.palDimensions.caseHeight * APP_SCALE_PIXEL_PER_INCH);
		gBoxSize.width_pixel = (UDINT)(gPallete.palCfg.palDimensions.caseWidth * APP_SCALE_PIXEL_PER_INCH);
		gBoxSize.length_pixel = (UDINT)(gPallete.palCfg.palDimensions.caseLength * APP_SCALE_PIXEL_PER_INCH);
			
		//appDefineBoxLayer();
		appDefineBoxLayerNew();
		gCamApp.state = appStepDrwInit;
	}
	
	
}
//eof

