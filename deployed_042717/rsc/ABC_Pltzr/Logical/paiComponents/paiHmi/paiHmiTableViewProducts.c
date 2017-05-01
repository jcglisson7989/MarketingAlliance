/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiTableViewPersons.c
 * Author: goran
 * Created: November 24, 2013
 ********************************************************************
 * Implementation of program hmiTableViewProducts
 ********************************************************************/

#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

/** 
Bit manipulaiton utility functions.
 */
//#include <../../bglib/bgBitUtilities.h>

/** 
String manipulaiton utility functions.
 */
#include <../../bglib/bgsprintf.h>
//#include <../../bglib/bgstring.h>

//#include <../../RecFIFO/fifotest/fifoif.h>
/*
###############################################################################
Table View support functions
###############################################################################
*/

/*
Display table background grid (i.e. each odd row in one color, each even row in
a different color
*/
void tableViewShowGridProducts(hmiTableProducts_typ* p)
{
	int ii;
	
	for(ii=0; ii<=p->viewIndexMax; ii++){
		//select a different collor scheme for each row of the table
		if(ii%2){
			p->itemsInView[ii].ctrl.bgdColorIndex = 1;				
		}else{
			p->itemsInView[ii].ctrl.bgdColorIndex = 0;						
		}		
	}
}

void tableFilterExecuteProducts(hmiTableProducts_typ* p)
{
	if(!p)
		return;
		
	p->executeFilter = 1;//execute filter request; cleared upon filter execution
}
static int tableFilterIsUpdateProducts(hmiTableProducts_typ* p, int* filterType)
{
	int filterLocal = 0;
	int filterDB = 0;
	
	if(!p){
		if(filterType)
			*filterType = 0;
		return 0;	
	}
	
	//filter setting changed?
	if( !p->executeFilter && 
		(p->shiftFilter == p->shiftFilterOld) && 
		(p->activeFilter == p->activeFilterOld) && 
		(p->assignedFilter == p->assignedFilterOld) && 
		(p->azFilterFirstName == p->azFilterFirstNameOld) && 
		(p->azFilterLastName == p->azFilterLastNameOld)
	){
		//no changes for filters that required DB request
	}else{
		filterDB = 1;
	}

	if( (p->assignedFilter == p->assignedFilterOld) ){
		//no changes for filters that are performed localy
	}else{
		filterLocal = 1;
	}
	
	p->executeFilter = 0;
	p->shiftFilterOld = p->shiftFilter;
	p->activeFilterOld = p->activeFilter;
	p->assignedFilterOld = p->assignedFilter;
	p->azFilterLastNameOld = p->azFilterLastName;
	p->azFilterFirstNameOld = p->azFilterFirstName;

	*filterType = filterDB + (2 * filterLocal);//bit0-filterDB, bit1-filterLocal
	
	return 1;
}
/*
Init table based person viewer
*/
void tableViewProductsInit(hmiTableProducts_typ* p, hmiTableItemDataProduct_typ* pItemsAll, UDINT itemCount, UDINT viewIndexMax, char* pDBTableName, int jsonSQLQueryid)
{
	int ii;
	
	if(!p || !pItemsAll || !itemCount || !viewIndexMax)
		return;

	
	p->pItemsAll = (UDINT)pItemsAll;

	p->viewIndexMax = viewIndexMax;
	if(p->viewIndexMax > hmiTableProductsMAXVIEWINDEX){
		p->viewIndexMax = hmiTableProductsMAXVIEWINDEX;
	}
	
	tableViewShowGridProducts(p);
	
	//reset selection/activate indexes and datapoints wired to hotspots
	p->selectedItem = -1;
	p->selectedViewItem = -1;
	p->selectViewItemDataPoint = -1;
	p->activateViewItemDataPoint = -1;
	if(pDBTableName)
		brsstrcpy((UDINT)p->activeDBTableName, (UDINT)pDBTableName);
	p->activeSQLid = jsonSQLQueryid;
	
	//simulate some data
	p->itemCountUnfiltered = 0;
	p->itemCount = 0;
	for(ii=0; ii<itemCount;ii++){
		if(pItemsAll[ii].usedEntry){
			p->itemCountUnfiltered++;
			p->itemCount++;
		}
	}	
}

/*
Hide (don't show) table row data at a selected row. Result is an empty line.
*/
static void productTableHideItemAtIndex(hmiTableProducts_typ* p, int viewIndex)
{
	if(!p || viewIndex > p->viewIndexMax)
		return;
	p->itemsInView[viewIndex].ctrl.visibilityControl = 1;
}

/*
Show (don't hide) table row data at a selected row. Result is an line that contais all columns (i.e. text fields).
*/
static void productTableShowItemAtIndex(hmiTableProducts_typ* p, int viewIndex)
{
	if(!p || viewIndex > p->viewIndexMax)
		return;
	
	//convert numerics into txt
	//bgsprintf(p->itemsInView[viewIndex].data.employeeIdTxt, "%d", p->itemsInView[viewIndex].data.employeeId);
	bgsprintf(p->itemsInView[viewIndex].data.indexTxt, "%d", p->itemsInView[viewIndex].data.index);
	//bgsprintf(p->itemsInView[viewIndex].data.shiftTxt, "%d", p->itemsInView[viewIndex].data.shift);
	
	//make item visible
	p->itemsInView[viewIndex].ctrl.visibilityControl = 0;
}

/*
Display table view.
*/
void tableViewShowProducts(hmiTableProducts_typ* p)
{
	int ii, jj;
	hmiTableItemDataProduct_typ* pItemsAll;
	
	
	if(!p || !p->pItemsAll)
		return;
	
	pItemsAll = (hmiTableItemDataProduct_typ*)p->pItemsAll;
	
	for(ii=0, jj = p->viewIndex; ii<=p->viewIndexMax; jj++){
		if(pItemsAll[jj].index < 0)
			continue;

		if(jj<p->itemCountUnfiltered){
			brsmemcpy((UDINT)&p->itemsInView[ii].data, (UDINT)&pItemsAll[jj], sizeof(hmiTableItemDataProduct_typ) );
			productTableShowItemAtIndex(p, ii);
		}else{
			productTableHideItemAtIndex(p, ii);
		}		
		ii++;
	}	
}	


/*
Selection (i.e. row highlighting) of the table row.
*/
static void tableViewItemSelectionProducts(hmiTableProducts_typ* p)
{
	if(!p)
		return;
	
	//table item selection logic
	//selectViewItemDataPoint is connected to a hotstop above the table line. Each line sets a different 
	//number that corepsonds to the visible (table) line number.
	if( (p->selectViewItemDataPoint >= 0) && (p->selectViewItemDataPoint <= p->viewIndexMax)){
		//check if a table line is already selected
		if(p->selectedViewItem < 0){
			//no item selected > select it now
			p->selectedViewItem = p->selectViewItemDataPoint; //save selected line for lated
			p->bgdColorIndexOldSelection = p->itemsInView[p->selectedViewItem].ctrl.bgdColorIndex;//save current color index for the line to be able to restore it
			p->itemsInView[p->selectedViewItem].ctrl.bgdColorIndex = 2;//select 3-rd color from the map
			//save current selection
			p->selectedViewItem = p->selectViewItemDataPoint;			
		}else
			if(p->selectedViewItem == p->selectViewItemDataPoint){
			//same item is already selected > deselect it now (toggle selection)
			//restore background color for the line
			p->itemsInView[p->selectedViewItem].ctrl.bgdColorIndex = p->bgdColorIndexOldSelection;
			//reset selection status
			p->selectedViewItem = -1;
		}else{
			//deactivate old selection, activate new selection
			p->itemsInView[p->selectedViewItem].ctrl.bgdColorIndex = p->bgdColorIndexOldSelection;
			p->bgdColorIndexOldSelection = p->itemsInView[p->selectViewItemDataPoint].ctrl.bgdColorIndex;
			p->itemsInView[p->selectViewItemDataPoint].ctrl.bgdColorIndex = 2;	
			//save current selection
			p->selectedViewItem = p->selectViewItemDataPoint;			
		}
				
		//calculate a line from the entire table that is currently selected
		p->selectedItem = -1;
		if(p->selectedViewItem >= 0)
			p->selectedItem = p->selectedViewItem + p->viewIndex;
			
		//reset datapoint connected to hotspots
		p->selectViewItemDataPoint = -1;
	}
}

static void tableViewRefreshProducts(hmiTableProducts_typ* p)
{
	p->selectedViewItem = -1;//invalidate view selection for a proper redraw of the selected item
	tableViewShowGridProducts(p); //redraw table layout
	tableViewShowProducts(p); //redraw table data
}

static void tableViewScrollProducts(hmiTableProducts_typ* p)
{
	if(!p || !p->itemCount)
		return;

	//if no item is selected, and any scroll key pressed, just select a top item on the list
	if( (p->selectedItem < 0) && 
		(p->btnScrollLineUp || p->btnScrollPageUp || p->btnScrollLineDw || p->btnScrollPageDw)){
		p->btnScrollLineUp = 0; p->btnScrollPageUp = 0;
		p->btnScrollLineDw = 0; p->btnScrollPageDw = 0;
		//item is NOT selected > select the top item	
		p->selectViewItemDataPoint = 0; 
		tableViewItemSelectionProducts(p);
		return;	
	}
	
	//table scroll logic
	if(p->btnScrollLineUp){
		p->btnScrollLineUp = 0;
		
		if(!p->selectedItem){
			return;//top item is already selected > nothing to do		
		}

		if(!p->selectedViewItem){
			//selected view item is at the TOP
			//is the view index > 0 (which means that scroll window has a chance to to move up)
			if(p->viewIndex){
				//view index is not all the way up > scroll it up
				p->viewIndex--;
				tableViewRefreshProducts(p);//display the entire table
			}				
			p->selectViewItemDataPoint = 0;//select the top line in the view
		}else{
			//selected view item is not the TOP > need to scroll up selection within the visible view
			p->selectViewItemDataPoint = p->selectedViewItem -  1;		
		}
		//update selection
		tableViewItemSelectionProducts(p);
		return;
	}

	if(p->btnScrollLineDw){
		p->btnScrollLineDw = 0;

		//item is already selected > scroll line dw		
		if(p->selectedItem == (p->itemCount - 1)){
			//last item is already selected
			return;		
		}

		if(p->selectedViewItem >= p->viewIndexMax){
			//selected view item is the LAST item in the view
			if(p->viewIndex < (p->itemCount - (p->viewIndexMax + 1) ) ){
				//view index can be further moved  > scroll
				p->viewIndex++;
				tableViewRefreshProducts(p);
			}				
			p->selectViewItemDataPoint = p->viewIndexMax;//select last item in the table view
		}else{
			//selected view item is not the BOTTOM > scroll
			p->selectViewItemDataPoint = p->selectedViewItem +  1;		
		}
		tableViewItemSelectionProducts(p);
		return;
	}	
	
	if(p->btnScrollPageUp){
		p->btnScrollPageUp = 0;
				
		//is view window at the top?
		if(p->viewIndex){
			//no > scroll up by the page size 
			p->viewIndex -= p->viewIndexMax+1;
			//viewIndex cann't be < 0!
			if(p->viewIndex < 0){
				p->viewIndex = 0;	
				p->selectViewItemDataPoint = 0; 
			}else{
				p->selectViewItemDataPoint = p->selectedViewItem; 			
			}
			tableViewRefreshProducts(p);//display the entire table
		}else{
			//view window is alreday all the way up > select the top line on the view
			if(p->selectedViewItem)
				p->selectViewItemDataPoint = 0; 
		}
		//redraw selection
		tableViewItemSelectionProducts(p);
		return;		
	}
	
	if(p->btnScrollPageDw){
		p->btnScrollPageDw = 0;
		
		//is the selection at the bottom?
		if((p->itemCount -1) <= p->selectedItem){
			//view window is alreday all the way dw > select the bottom line on the view			
			return;			
		}
		
		//no > scroll dw by the page size
		if( ((p->itemCount) / (p->viewIndexMax+1)) > ((p->selectedItem + 1) / (p->viewIndexMax+1))){
			p->viewIndex += p->viewIndexMax+1;
			if(p->viewIndex > (p->itemCount - 1 )){
				p->viewIndex = (p->itemCount - 1);
			}
			//p->selectViewItemDataPoint = p->selectedViewItem; 
			p->selectViewItemDataPoint = 0; 
			tableViewRefreshProducts(p);
		}
		
		//redraw selection
		tableViewItemSelectionProducts(p);
		return;		
	}
	
}



/*
SELECT id,name,description,yield,pieceweight FROM products
*/
static void tableFilterProducts(hmiTableProducts_typ* p)
{
	int filterMode;//bit0-DBfilter, bit1-localFilter
	
	char textBuf[32];
	char gUdpClient_txbuf[768];
	
	if(!p || !p->pItemsAll)
		return;
	
	//check if running a filter is requested?
	if( !tableFilterIsUpdateProducts(p, &filterMode) )
		return ;
		
	if(filterMode & 0x2){
		//local filter (station assigment)
		//DBG(lgr, "Apply filter: station assing");
	}
	
	if(!(filterMode & 0x1)){
		return;
	}
	

	brsstrcpy((UDINT)&gUdpClient_txbuf[0], (UDINT)"{\"paipvilite\": \"1.0\", \"method\": \"executesqlquery\", \"params\": {\"sqlquery\":\"SELECT id,prod_name,description,yield,pieceweight,pass_score,lightFeatYieldRedPct,lightFeatYieldGreenPct,lightFeatPcPMRed,lightFeatPcPMGreen,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_1,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_2,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_3,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_4,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_5,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_6,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_7,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_8,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_9,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_10,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_11,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_dem_12,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_1,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_2,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_3,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_4,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_5,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_6,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_7,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_8,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_9,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_10,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_11,");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"defect_desc_12");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)" FROM ");
	
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)p->activeDBTableName);
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"\"}, \"id\": ");
	brsitoa(p->activeSQLid, (UDINT)textBuf);
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)textBuf);
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"}");
		
	pushSQLQuery(p->activeSQLid, (unsigned char*)gUdpClient_txbuf, brsstrlen((UDINT)gUdpClient_txbuf));
	//gUdpClient.clientIf.iSend = 1;
}

DINT tableFilterGetSelectedItemRawIndexProducts(hmiTableProducts_typ* p, int selectedItem)
{
	DINT ii;
	hmiTableItemDataProduct_typ* pItemsAll;
	
	if(!p || !p->pItemsAll)
		return 0;
	
	pItemsAll = (hmiTableItemDataProduct_typ*)p->pItemsAll; //ptr to an array of all records	
	//iterate over all records
	for(ii=0; ii<p->itemCountUnfiltered; ii++, pItemsAll++){
		if((pItemsAll->index < 0) || (pItemsAll->index != selectedItem))
			continue;
		return ii;
	}

	return -1; 
}


void tableProductsCyclic()
{
	hmiTableProducts_typ* pT = &gHmi.tableViewProducts;
	
	//table show view
	tableViewShowProducts(pT);
	
	//table item (row) selection logic
	tableViewItemSelectionProducts(pT);

	//table scroll logic
	tableViewScrollProducts(pT);
	
	//table filtering (i.e. shift 1 or 2, active or not active)
	tableFilterProducts(pT);
}
//EOF
