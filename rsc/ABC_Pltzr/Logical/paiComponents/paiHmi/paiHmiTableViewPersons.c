/********************************************************************
 * COPYRIGHT -- pai
 ********************************************************************
 * Program: hmilogic
 * File: hmiTableViewPersons.c
 * Author: goran
 * Created: November 24, 2013
 ********************************************************************
 * Implementation of program hmiTableViewPersons
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
void tableViewShowGrid(hmiTablePersons_typ* p)
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



/*
Init table based person viewer
*/
void tableViewPersonsInit(hmiTablePersons_typ* p, hmiTableItemDataPerson_typ* pItemsAll, UDINT itemCount, UDINT viewIndexMax, char* pDBTableName, int jsonSQLQueryid)
{
	int ii;
	
	if(!p || !pItemsAll || !itemCount || !viewIndexMax)
		return;

	
	p->pItemsAll = (UDINT)pItemsAll;

	p->viewIndexMax = viewIndexMax;
	if(p->viewIndexMax > hmiTablePersonMAXVIEWINDEX){
		p->viewIndexMax = hmiTablePersonMAXVIEWINDEX;
	}
	p->viewIndex = 0;
	
	tableViewShowGrid(p);
	
	//reset selection/activate indexes and datapoints wired to hotspots
	p->selectedItem = -1;
	p->selectedViewItem = -1;
	p->selectViewItemDataPoint = -1;
	p->activateViewItemDataPoint = -1;
	if(pDBTableName)
		brsstrcpy((UDINT)p->activeDBTableName, (UDINT)pDBTableName);
	p->activeSQLid = jsonSQLQueryid;
	
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
static void personTableHideItemAtIndex(hmiTablePersons_typ* p, int viewIndex)
{
	if(!p || viewIndex > p->viewIndexMax)
		return;
	p->itemsInView[viewIndex].ctrl.visibilityControl = 1;
}

/*
Show (don't hide) table row data at a selected row. Result is an line that contais all columns (i.e. text fields).
*/
static void personTableShowItemAtIndex(hmiTablePersons_typ* p, int viewIndex)
{
	if(!p || viewIndex > p->viewIndexMax)
		return;
	
	//convert numerics into txt
	bgsprintf(p->itemsInView[viewIndex].data.employeeIdTxt, "%d", p->itemsInView[viewIndex].data.employeeId);
	bgsprintf(p->itemsInView[viewIndex].data.indexTxt, "%d", p->itemsInView[viewIndex].data.index);
	bgsprintf(p->itemsInView[viewIndex].data.shiftTxt, "%d", p->itemsInView[viewIndex].data.shift);
	
	//make item visible
	p->itemsInView[viewIndex].ctrl.visibilityControl = 0;
}

/*
Display table view.
*/
void tableViewShow(hmiTablePersons_typ* p)
{
	int ii, jj;
	hmiTableItemDataPerson_typ* pItemsAll;
	
	
	if(!p || !p->pItemsAll)
		return;
	
	pItemsAll = (hmiTableItemDataPerson_typ*)p->pItemsAll;
	
	for(ii=0, jj = p->viewIndex; ii<=p->viewIndexMax; jj++){
		if(pItemsAll[jj].index < 0)
			continue;

		if(jj<p->itemCountUnfiltered){
			brsmemcpy((UDINT)&p->itemsInView[ii].data, (UDINT)&pItemsAll[jj], sizeof(hmiTableItemDataPerson_typ) );
			personTableShowItemAtIndex(p, ii);
		}else{
			personTableHideItemAtIndex(p, ii);
		}		
		ii++;
	}	
}	


/*
Selection (i.e. row highlighting) of the table row.
*/
static void tableViewItemSelection(hmiTablePersons_typ* p)
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


/*
Logic to set / reset an "active" property (i.e. column) of a persons table
*/
static void tableViewItemActive(hmiTablePersons_typ* p)
{
	UDINT rawIndex;
	hmiTableItemDataPerson_typ* pItemsAll;
	
	
	if(!p || !p->pItemsAll)
		return;
	
	return;//TODO: disable section below until a full support is available; that way, changing activ/inactive button on the 
	//worker / inspector screen would not be working at all (instead of giving a false impression that the tnings are working)
	
	pItemsAll = (hmiTableItemDataPerson_typ*)p->pItemsAll;
	//table item active/inactive logic
	//activateViewItemDataPoint is connected to a hotstop above the active field within a table line. Each line sets a different 
	//number that corepsonds to the visible (table) line number.
	if( (p->activateViewItemDataPoint >= 0) && (p->activateViewItemDataPoint <= p->viewIndexMax)){
		//check if a table line is already active
		if(p->itemsInView[p->activateViewItemDataPoint].data.active){
			p->itemsInView[p->activateViewItemDataPoint].data.active = 0;
			rawIndex = p->itemsInView[p->activateViewItemDataPoint].data.indexRaw;
			pItemsAll[rawIndex].active = 0;
			//execute DB update
			
		}else{
			p->itemsInView[p->activateViewItemDataPoint].data.active = 1;
			rawIndex = p->itemsInView[p->activateViewItemDataPoint].data.indexRaw;			
			pItemsAll[rawIndex].active = 1;
			//execute DB update
			
		}
		p->activateViewItemDataPoint = -1;
	}
}


static void tableViewRefresh(hmiTablePersons_typ* p)
{
	p->selectedViewItem = -1;//invalidate view selection for a proper redraw of the selected item
	tableViewShowGrid(p); //redraw table layout
	tableViewShow(p); //redraw table data
}

static void tableViewScroll(hmiTablePersons_typ* p)
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
		tableViewItemSelection(p);
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
				tableViewRefresh(p);//display the entire table
			}				
			p->selectViewItemDataPoint = 0;//select the top line in the view
		}else{
			//selected view item is not the TOP > need to scroll up selection within the visible view
			p->selectViewItemDataPoint = p->selectedViewItem -  1;		
		}
		//update selection
		tableViewItemSelection(p);
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
				tableViewRefresh(p);
			}				
			p->selectViewItemDataPoint = p->viewIndexMax;//select last item in the table view
		}else{
			//selected view item is not the BOTTOM > scroll
			p->selectViewItemDataPoint = p->selectedViewItem +  1;		
		}
		tableViewItemSelection(p);
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
			tableViewRefresh(p);//display the entire table
		}else{
			//view window is alreday all the way up > select the top line on the view
			if(p->selectedViewItem)
				p->selectViewItemDataPoint = 0; 
		}
		//redraw selection
		tableViewItemSelection(p);
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
			tableViewRefresh(p);
		}
		
		//redraw selection
		tableViewItemSelection(p);
		return;		
	}
	
}

/*
Persons table view filter
shiftFilter - 0-show all (both shifts);1-shift1;2-shift2
activeFilger - 0-show all (active and not active); 1-show active only
*/
void tableFilterPersonsSet(hmiTablePersons_typ* p, int shiftFilter, int activeFilter, int assignedFilter)
{
	if(!p)
		return;
		
	p->shiftFilter = 0;//default: no filtering on shift
	if( (shiftFilter >= 0) && (shiftFilter <= 2)){
		p->shiftFilter = shiftFilter;
	}
	
	p->activeFilter = 0;//default: no filtering on active
	if( (activeFilter >= 0) && (activeFilter <= 1)){
		p->activeFilter = activeFilter;
	}

	p->assignedFilter = 0;//default: no filtering on person assigned to a station
	if( (assignedFilter >= 0) && (assignedFilter <= 1)){
		p->assignedFilter = assignedFilter;
	}
	
}

void tableFilterExecute(hmiTablePersons_typ* p)
{
	if(!p)
		return;
		
	p->executeFilter = 1;//execute filter request; cleared upon filter execution
}


int tableFilterPersonsActive(hmiTableItemDataPerson_typ* pItem, int activeFilter)
{
	if(activeFilter == 1){
		//pass only active items
		if(pItem->active == 1){
			return 1;
		}
		return 0;
	}

	return 1;//pass all items
}

int tableFilterPersonsShift(hmiTableItemDataPerson_typ* pItem, int shiftFilter)
{
	switch(shiftFilter){
		case 1://pass shift 1 only items
			if(pItem->shift == 1){
				return 1;
			}
			return 0;
		break;
		case 2://pass shift 2 only items
			if(pItem->shift == 2){
				return 1;
			}
			return 0;
		break;
		default:
		break;
	}	
	return 1;//pass all items
}

static int tableFilterIsUpdate(hmiTablePersons_typ* p, int* filterType)
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
SELECT id,lastname,firstname,employeeid,active,shift FROM workers  ORDER BY lastname,firstname

SELECT id,lastname,firstname,employeeid,active,shift FROM workers  WHERE  active = 1  AND  shift = 1  ORDER BY lastname  ,firstname
SELECT id,lastname,firstname,employeeid,active,shift FROM workers  WHERE  active = 1  ORDER BY lastname  ,firstname
SELECT id,lastname,firstname,employeeid,active,shift FROM workers  WHERE  active = 0  ORDER BY lastname  ,firstname
SELECT id,lastname,firstname,employeeid,active,shift FROM workers  WHERE  shift =  2 ORDER BY lastname  ,firstname
SELECT id,lastname,firstname,employeeid,active,shift FROM workers  WHERE  active = 0  AND  shift =  2 ORDER BY lastname  ,firstname

SELECT id,lastname,firstname,employeeid,active,shift FROM workers  ORDER BY lastname  ,firstname  DESC
SELECT id,lastname,firstname,employeeid,active,shift FROM workers  ORDER BY lastname  DESC  ,firstname  DESC
*/
static void tableFilterPersons(hmiTablePersons_typ* p)
{
	int filterMode;//bit0-DBfilter, bit1-localFilter
	
	char* pActiveFilter;
	char* pShiftFilter;
	char* pAZSortLast;
	char* pAZSortFirst;
	char textBuf[32];
	char gUdpClient_txbuf[255];
	
	if(!p || !p->pItemsAll)
		return;
	
	//check if running a filter is requested?
	if( !tableFilterIsUpdate(p, &filterMode) )
		return ;
		
	if(filterMode & 0x2){
		//local filter (station assigment)
		//DBG(lgr, "Apply filter: station assing");
	}
	
	if(!(filterMode & 0x1)){
		return;
	}
	
	switch(p->activeFilter){
		case 1: pActiveFilter = " active = 1 ";break;	
		case 2: pActiveFilter = " active = 0 ";break;	
		default:
			pActiveFilter = 0;
			break;
	}
	switch(p->shiftFilter){
		case 1: pShiftFilter = " shift = 1 ";break;	
		case 2: pShiftFilter = " shift = 2 ";break;	
		default:
			pShiftFilter = 0;
			break;
	}
	switch(p->azFilterLastName){
		case 1: pAZSortLast = " DESC ";break;	
		default:
			pAZSortLast = 0;	
			break;
	}
	switch(p->azFilterFirstName){
		case 1: pAZSortFirst = " DESC ";break;	
		default:
			pAZSortFirst = 0;
			break;
	}
		
	
	brsstrcpy((UDINT)&gUdpClient_txbuf[0], (UDINT)"{\"paipvilite\": \"1.0\", \"method\": \"executesqlquery\", \"params\": {\"sqlquery\":\"SELECT id,lastname,firstname,employeeid,active,shift FROM ");
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)p->activeDBTableName);
	if(pActiveFilter || pShiftFilter){
		brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)" WHERE ");
		if(pActiveFilter)
			brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)pActiveFilter);
		if(pActiveFilter && pShiftFilter)	
			brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)" AND ");
		if(pShiftFilter)
			brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)pShiftFilter);
	}
	
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)" ORDER BY lastname ");
	if(pAZSortLast)
		brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)pAZSortLast);
		
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)" ,firstname ");
	if(pAZSortFirst)
		brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)pAZSortFirst);
		
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"\"}, \"id\": ");
	brsitoa(p->activeSQLid, (UDINT)textBuf); 
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)textBuf);
	brsstrcat((UDINT)&gUdpClient_txbuf[0], (UDINT)"}");
	
	pushSQLQuery(0, (unsigned char*)gUdpClient_txbuf, brsstrlen((UDINT)gUdpClient_txbuf));
	
	//gUdpClient.clientIf.iSend = 1;
}

DINT tableFilterGetSelectedItemRawIndex(hmiTablePersons_typ* p, int selectedItem)
{
	DINT ii;
	hmiTableItemDataPerson_typ* pItemsAll;
	
	if(!p || !p->pItemsAll)
		return 0;
	
	pItemsAll = (hmiTableItemDataPerson_typ*)p->pItemsAll; //ptr to an array of all records	
	//iterate over all records
	for(ii=0; ii<p->itemCountUnfiltered; ii++, pItemsAll++){
		if((pItemsAll->index < 0) || (pItemsAll->index != selectedItem))
			continue;
		return ii;
	}

	return -1; 
}


void tablePersonsCyclic()
{
	hmiTablePersons_typ* pT = &gHmi.tableViewPersons;
	
	//table show view
	tableViewShow(pT);
	
	//table item (row) selection logic
	tableViewItemSelection(pT);

	//table item active/inactive logic
	tableViewItemActive(pT);
	
	//table scroll logic
	tableViewScroll(pT);
	
	//table filtering (i.e. shift 1 or 2, active or not active)
	tableFilterPersons(pT);
}
//EOF
