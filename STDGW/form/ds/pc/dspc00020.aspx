<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">

<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<head>
    <title>PURCHASE PRICE ENTRY</title>
</head>

<script type="text/javascript" language="javascript">

var flag;

var G_PK            = 0,
    G_SLIP_NO       = 1,
    G_SLIP_NO 		= 2,
    G_PARTNER 		= 3,
    G_DEPT    		= 4,
    G_STATUS        = 5,
	G_CHARGER       = 6; 

var G1_DETAIL_PK    	= 0,
    G1_MASTER_PK   		= 1,
	G1_SEQ              = 2,
	G1_ITEM_PK   		= 3,
	G1_ITEM_CODE        = 4,
	G1_ITEM_NAME        = 5,
	G1_UOM				= 6,
	G1_UNIT_PRICE       = 7,
	G1_TAX_RATE			= 8,
	G1_PART_PK			= 9,
	G1_PARTNER_ID		= 10,
	G1_PARTNER_NAME		= 11,
	G1_PO_DEPT		    = 12,
	G1_IN_PRICE_01      = 13,  
    G1_REMARK      		= 14,
	G1_PERCENT     		= 15;
        	
var arr_FormatNumber = new Array();	
        
//======================================================================

function OnToggle(pos)
{
    switch (pos)
    {
        case '1':
            var left = document.all("left"); 
            var right = document.all("right"); 
            var imgArrow = document.all("imgArrow"); 

            if(imgArrow.status == "expand")
            {
                left.style.display="none";
                imgArrow.status = "collapse";
                right.style.width="100%";
                imgArrow.src = "../../../system/images/button/next.gif";
            }
            else
            {
                left.style.display="";
                imgArrow.status = "expand";
                right.style.width="70%";
                imgArrow.src = "../../../system/images/button/previous.gif";
            }        
        break; 
    }    
}
 
//=================================================================================

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
	txtChargerName.SetReadOnly(true);
	txtSlipNo.SetReadOnly(true);
	txtPartnerID.SetReadOnly(true);	
	txtPartnerName.SetReadOnly(true);
	
	dtSeachFrom.SetDataText(System.AddDate(dtSeachTo.GetData(), -90));
	
	FormFormat();   
	
	OnAddNew('Master');      
}
//=================================================================================
function FormFormat()
{  
    var data="";  	
   
    //--------STATUS
    data = "data|1|SAVED|2|SUBMITED|3|APPROVED|4|CANCEL||-";
    lstStatus.SetDataText(data); 
    lstStatus.value = '';	
	
	data = "data|0|0%|1|1%|2|2%|3|3%|4|4%|5|5%|6|6%|7|7%|8|8%|9|9%|10|10%|11|11%|12|12%|13|13%|14|14%|15|15%|16|16%|17|17%|18|18%|19|19%|20|20%|21|21%|22|22%|23|23%|24|24%|25|25%|26|26%|27|27%|28|28%|29|29%|30|30%|31|31%|32|32%|33|33%|34|34%|35|35%|36|36%|37|37%|38|38%|39|39%|40|40%";
    lstPercent.SetDataText(data); 
    lstPercent.value = '0';	

	data = "data|10|REFRESH PRICE LIST|20|MODIFY PRICE LIST";
    lstSlipType.SetDataText(data); 
    lstSlipType.value = '10';	
	 	 	   
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>||";    
    lstPriceType.SetDataText(data); 
    lstPriceType.value = "";    

    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
    lstCurrency.SetDataText(data);     
	
	data = "<%=ESysLib.SetGridColumnDataSQL(" select pk,DEPT_ID || ' * '|| DEPT_NAME from TLG_PO_DEPT a where  del_if=0 order by DEPT_ID " ) %>|#;";       
	grdDetail.SetComboFormat(G1_PO_DEPT,data);
	
	data = "<%=ESysLib.SetListDataSQL("select pk,DEPT_ID || ' * '|| DEPT_NAME from TLG_PO_DEPT a where  del_if=0 order by DEPT_ID")%>||"; 
    lstDept.SetDataText(data);
	lstDept.value = '';
	
	grdDetail.GetGridControl().ColFormat(G1_UNIT_PRICE)    = "###,###,###.###"; 
	grdDetail.GetGridControl().ColFormat(G1_TAX_RATE)      = "###,###,###"; 
	
	grdDetail.GetGridControl().ColFormat(G1_IN_PRICE_01)   = "###,###,###.###"; 
	 
	arr_FormatNumber[G1_UNIT_PRICE]  = 3;
	arr_FormatNumber[G1_TAX_RATE]    = 0;
	arr_FormatNumber[G1_IN_PRICE_01] = 3;
}
 
//=================================================================================
function OnAddNew(pos)
{
	switch (pos)
	{
		case 'Master':
			if ( data_dspc00020_1.GetStatus() != 20 )
		    {
		        data_dspc00020_1.StatusInsert();
		        grdDetail.ClearData();
				
				txtChargerName.text = "<%=Session("USER_NAME")%>";
                txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
				
				txtSlipNo.text = "<< New Slip >>"
		        //----------------     
		        flag = "view";                          
		    }
		    else
		    {
		        alert("Already add new. Pls input data !!!");
		    }			
		break;
		
		case 'ITEM':
					var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
					var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
					
					if ( object != null )
					{
                        for( var i=0; i < object.length; i++)	  
                        {	
                            var arrTemp = object[i];
							
                            grdDetail.AddRow();     
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,   	   grdDetail.rows-1 );
							
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK,   arrTemp[0] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[1] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, arrTemp[2] );
							grdDetail.SetGridText( grdDetail.rows-1, G1_UOM, 	   arrTemp[5] );
                        }		
					}  
		break;	

		case 'DETAIL':
			grdDetail.AddRow();     
            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1 );
		break;	
	
	}    
	
}
//=================================================================================
function OnSave(obj)
{ 
    if(obj == 'Master')
    {
        flag='save';
        data_dspc00020_1.Call();
    }    
    else if(obj == 'Detail')
    {
        data_dspc00020_2.Call();
    }
}
//=================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_dspc00020': //SEARCH  
            for( var i=0; i<grdSearch.rows; i++)
            {
                    if ( grdSearch.GetGridData( i, G_STATUS) == 2 )
                    { 
                        grdSearch.SetCellBgColor( i, G_SLIP_NO, i, G_STATUS, 0xCCFFFF );
                    } 
					else if ( grdSearch.GetGridData( i, G_STATUS) == 3 ) 
					{
						grdSearch.SetCellBgColor( i, G_SLIP_NO, i, G_STATUS, 0xFFFFCC );
					}
					else if ( grdSearch.GetGridData( i, G_STATUS) == 4 ) 
					{
						grdSearch.SetCellBgColor( i, G_SLIP_NO, i, G_STATUS, 0xFFCCFF );
					}  
            }     
        break;
		
        case 'data_dspc00020_1': //MASTER
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                    }    
                }                
                OnSave('Detail');  
            } 
            else
            {
                data_dspc00020_2.Call('SELECT'); 
            }    
        break;
        
		case 'data_dspc00020_2':
			if ( grdDetail.rows > 1 )
			{
				grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);		
			}
			
			lblRecord.text = (grdDetail.rows-1)+" (s)";
		break;
		
        case 'pro_dspc00020': // SUBMIT
            alert(txtValueReturn.text);
			
			data_dspc00020_1.Call('SELECT');			
        break;
        
        case 'pro_dspc00020_1': // COPY
            alert(txtValueReturn.text);
			
			data_dspc00020.Call('SELECT');			
        break;  

		case 'pro_dspc00020_update_price':
			alert(txtValueReturn.text);
		break;	
    }  
}
//=================================================================================
function OnDelete(pos) 
{
    switch (pos)
    {
        case 'Master':// delete master
            if ( confirm('Do you want to delete this slip?'))
            {
                flag='delete';
                data_dspc00020_1.StatusDelete();
                data_dspc00020_1.Call();
            }   
        break;
 		
		case 'Detail':
			if ( grdDetail.GetGridData( grdDetail.row, G1_DETAIL_PK ) == '' )
            {
                grdDetail.RemoveRow();
            }
            else
            {   
                grdDetail.DeleteRow();
            }   		
		break;
    }      
}
//==============================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}

//=================================================================================
function OnReport(obj)
{
}
 
//=================================================================================
function OnSearch(pos)
{ 
    switch(pos)
    {
        case 'grdSearch':
            data_dspc00020.Call('SELECT');
        break;
		
        case 'Master':
			if ( grdSearch.row > 0 )
			{
            	txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK);
			 
           	 	data_dspc00020_1.Call('SELECT');
			}	
        break;
		
		case 'Detail' :
			data_dspc00020_2.Call('SELECT');
		break; 
    }
}
 
//=================================================================================
function OnGridCellDblClick(objGrid)
{
}     
//========================================================================================
function OnProcess(pos)
{
	switch(pos)
	{
		case 'Submit':
			if(txtMasterPK.text != '')
		    {
		        pro_dspc00020.Call();
		    }		
		break;
		case 'Copy':
		    if ( txtMasterPK.text == "" )
		    {
		        alert("Please select one S/P to copy !!!");
		    }
		    else
		    { 
				if ( confirm('Do you want to copy this S/P ?') )
				{ 
		        	pro_dspc00020_1.Call();
				}	
		    }  		
		break;	

		case 'UPDATE_PRICE':
		    if ( txtMasterPK.text == "" )
		    {
		        alert("Please select one S/P to process !!!");
		    }
		    else
		    { 
				if ( confirm('Do you want to update price to P/R and P/O ?') )
				{ 
		        	pro_dspc00020_update_price.Call();
				}	
		    }  		
		break;	

		case "PRICE":
			var temp_value;
			for ( var i=1; i<grdDetail.rows; i++)
			{
				temp_value = 0;
				if ( grdDetail.GetGridControl().isSelected(i) == true )
				{
					if(!isNaN(grdDetail.GetGridData( i, G1_IN_PRICE_01).toString())){
						if(Number(grdDetail.GetGridData( i, G1_IN_PRICE_01)) > 0){
							//grdDetail.SetGridText(i,G1_UNIT_PRICE,Number(grdDetail.GetGridData( i, G1_UNIT_PRICE)) + Number(grdDetail.GetGridData( i, G1_IN_PRICE_01)) * Number(lstPercent.value) *0.01);
							temp_value = Number(grdDetail.GetGridData( i, G1_IN_PRICE_01)) * (Number(lstPercent.value) * 0.01 + 1);
							grdDetail.SetGridText( i, G1_UNIT_PRICE, temp_value);
						}
					}
				}
			}
		break;
	}    
}

//========================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Detail':
			var event_row = event.row;
			var event_col = event.col;
			
			if ( event_col == G1_PARTNER_ID || event_col == G1_PARTNER_NAME ) 
			{
				var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
				var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
				if ( object != null )
				{ 
					grdDetail.SetGridText( event_row, G1_PART_PK	  , object[0] );
					grdDetail.SetGridText( event_row, G1_PARTNER_ID	  , object[1] );	
					grdDetail.SetGridText( event_row, G1_PARTNER_NAME , object[2] );
				}
			}
			else if ( event_col == G1_UOM )
			{
				var path = System.RootURL + '/form/fp/ab/fpab00640.aspx?p_item_pk=' + grdDetail.GetGridData( event_row, G1_ITEM_PK ) + '&p_uom=' + url_encode(grdDetail.GetGridData( event_row, event_col ));
				var obj = System.OpenModal( path ,400 , 300, 'resizable:yes;status:yes');						
    	               
				if ( obj != null )
				{
	                grdDetail.SetGridText( event_row, event_col, obj[0]);
				}			
			}				
        break;           
				 
 		case 'Charger' :
                 var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( obj != null )
	             {
	                txtChargerPK.text   = obj[0];
                    txtChargerName.text = obj[2];
                 }	
	    break;		

		case 'Import' :			 
			var url =System.RootURL + '/form/ds/pc/dspc00020_import.xls';
        	window.open(url);	  
		break;	
	    		
		case 'Partner' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerPK.text   = object[0];
				txtPartnerID.text   = object[1];
                txtPartnerName.text = object[2];          
	         }
        break;	

		case 'Report':
			var path = System.RootURL + '/form/ds/pc/dspc00021.aspx';
			var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);				
		break;	
		
		case 'VALID' :
			if ( txtMasterPK.text == '' )
			{
				alert('PLS SELECT ONE SLIP.');
				return;
			}
			
			var path = System.RootURL + '/form/ds/pc/dspc00022.aspx?p_master_pk=' + txtMasterPK.text ;
	        var obj = System.OpenModal( path ,200 , 400, 'resizable:yes;status:yes');
		break;
    }	       
}

 //=================================================================================================
 function CheckInput()
 {   
   var row, col;
   
   row = event.row;
   col = event.col;
         
   if ( col == G1_UNIT_PRICE || col == G1_TAX_RATE )
   {
        var dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        } 				 
	}        
	
}	

//-------------------------read data form exel file ----------------
function ReadFiles()
{           
					var fl = document.getElementById("idtext").value;  
                             
                    var excel = new ActiveXObject("Excel.Application");
                    var excel_file  = excel.Workbooks.Open(fl);
                    var excel_sheet = excel.Worksheets("Sheet1"); 
                    var maxRow      = excel.Worksheets("Sheet1").UsedRange.Rows.Count;
					 
                    var lrow ;
                 
                    for(lrow = 3; lrow <= maxRow ; lrow++) 
                    {                           						 
						grdDetail.AddRow();   
								
						grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,   	   excel_sheet.Cells( lrow, 1 ).Value );
							
						grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, excel_sheet.Cells( lrow, 2 ).Value );
						grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, excel_sheet.Cells( lrow, 3 ).Value );
						grdDetail.SetGridText( grdDetail.rows-1, G1_UOM, 	   excel_sheet.Cells( lrow, 4 ).Value ); 
							
						grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,   excel_sheet.Cells( lrow, 5 ).Value );  
						grdDetail.SetGridText( grdDetail.rows-1, G1_PARTNER_ID,   excel_sheet.Cells( lrow, 6 ).Value ); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_PARTNER_NAME, excel_sheet.Cells( lrow, 7 ).Value ); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_PO_DEPT, 	  excel_sheet.Cells( lrow, 8 ).Value ); 
						grdDetail.SetGridText( grdDetail.rows-1, G1_REMARK, 	  excel_sheet.Cells( lrow, 9 ).Value ); 	
                    }    
					
                    lblRecord.text = (grdDetail.rows-1)+" (s)";
					
                    excel.Quit();
                    excel = null;
            
        
}

//=================================================================================
function url_encode(s) 
{
	string = s.replace(/\r\n/g,"\n");
	var utftext = "";

	for (var n = 0; n < string.length; n++) 
	{

		var c = string.charCodeAt(n);

		if (c < 128) 
		{
			utftext += String.fromCharCode(c);
		}
		else if ((c > 127) && (c < 2048)) 
		{
			utftext += String.fromCharCode((c >> 6) | 192);
			utftext += String.fromCharCode((c & 63) | 128);
		}
		else 
		{
			utftext += String.fromCharCode((c >> 12) | 224);
			utftext += String.fromCharCode(((c >> 6) & 63) | 128);
			utftext += String.fromCharCode((c & 63) | 128);
		}
	}
	return escape(utftext);
}

//====================================================
 function OnReport(para)
 {
    switch(para)
    {
 
		case 'FOSE01':
            
            var url =System.RootURL + '/reports/ds/pc/rpt_dspc00020_FOSE01.aspx?p_from_date=' + dtSeachFrom.value + '&p_to_date=' + dtSeachTo.value + '&p_slip_no=' + txtSlipNoSearch.text + '&p_item=' + txtItemSearch.text + '&p_pk=' + txtMasterPK.text;
			//alert(url);
            window.open(url, "_blank");  
			
        break;	
				 
    }
 }
//=================================================================================
</script>

<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_dspc00020" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1"	function="<%=l_user%>lg_SEL_dspc00020"	>	
				<input>
					<input  bind="dtSeachFrom" />
					<input  bind="dtSeachTo" />
					<input	bind="lstStatus"	/>
					<input	bind="txtSlipNoSearch"	/>
					<input	bind="txtItemSearch"	/>						
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_dspc00020_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"	function="<%=l_user%>lg_sel_dspc00020_1"	procedure="<%=l_user%>lg_UPD_dspc00020">	
				<input>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="dtSlipDate"	/>	
						<inout	bind="lstSlipType"	/>
						<inout	bind="txtChargerPK"	/>	
						<inout	bind="txtChargerName"	/>
						<inout	bind="txtDesc"	/>											
						<inout	bind="lblStatus"	/>							 
			            <inout  bind="lstPriceType" />
			            <inout  bind="lstCurrency" />
						<inout	bind="txtPartnerPK"	/>							 
			            <inout  bind="txtPartnerID" />
			            <inout  bind="txtPartnerName" />
						<inout  bind="lstDept" />	
						<inout  bind="dtStartDate" />
						<inout  bind="dtEndDate" />
				</input>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_dspc00020_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_dspc00020_2" procedure="<%=l_user%>lg_UPD_dspc00020_1">	
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
					<input  bind="txtItem" />
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Submit =====================================-->
    <gw:data id="pro_dspc00020" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_dspc00020"> 
                <input> 
			        <input bind="txtMasterPK" />  		
			    </input> 
                <output>
                    <output bind="txtValueReturn" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>
    <!--============================================= Copy =====================================-->
    <gw:data id="pro_dspc00020_1" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_dspc00020_1"> 
                <input> 
			        <input bind="txtMasterPK" />  		
			    </input> 
                <output>
                    <output bind="txtValueReturn" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>    
	<!--============================================= Copy =====================================-->
    <gw:data id="pro_dspc00020_update_price" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_pro_dspc00020_update_price"> 
                <input> 
			        <input bind="txtMasterPK" />  		
			    </input> 
                <output>
                    <output bind="txtValueReturn" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>    
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr>
            <td style="width: 30%; height: 100%" id="left">
                <table id="LeftBottomTB" style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date
                        </td>
						
                        <td style="width: 60%; white-space: nowrap">
                            <gw:datebox id="dtSeachFrom" lang="1" width="100%" />
                            ~
                            <gw:datebox id="dtSeachTo" lang="1" width="100%" />
                        </td>
						
                        <td style="width: 35%">
                            <gw:list id="lstStatus" styles="width:80" onchange="OnSearch('grdSearch')" />                            
                        </td>
						
						<td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
					
					<tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Item
                        </td>
                        <td style="width: 60%; white-space: nowrap" colspan=3 >
                            <gw:textbox id="txtItemSearch" styles='width:100%' onenterkey="OnSearch('grdSearch')" />
                        </td>						 
                    </tr>
					
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Slip No
                        </td>
                        <td style="width: 60%; white-space: nowrap" colspan=2 >
                            <gw:textbox id="txtSlipNoSearch" styles='width:100%' onenterkey="OnSearch('grdSearch')" />
                        </td>
						<td style="width: 5%; white-space: nowrap" align="right"  >
							<gw:icon id="idBtnCopy" img="2" text="Copy" styles='width:100%' onclick="OnProcess('Copy')" />
						</td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="6">
                            <gw:grid id='grdSearch' header='_PK|Slip No|Slip Date|Partner|Dept|_Status|Charger'
                                format='0|0|4|0|0|0|0' aligns='0|0|1|0|0|0|0' check='|||||' editcol='0|0|0|0|0|0|0' widths='0|1000|1200|2000|1000|0|2000'
                                sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%; height: 100%" align="center" valign="top" id="right">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="width: 100%; height: 1%">
						
						<td style="width: 5%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 30%; white-space: nowrap" colspan=2 >
                            <gw:textbox id="txtSlipNo" styles='width:100%' />
                        </td>
						
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtSlipDate" lang="1" width="10%" />                            
                        </td>
                       
                        <td align='center'  style="width: 46%" colspan=3 >
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
						
                        <td style="width: 1%">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:15%' onclick="OnProcess('Submit')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave('Master')" />
                        </td>
                    </tr>
					<tr style="width: 100%; white-space: nowrap">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Price type
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstPriceType" styles='width:100%' onchange="" />
                        </td>    						 
                        <td style="width: 10%">
                            <gw:list id="lstCurrency" styles='width:100%' onchange="" />
						</td>
						
						<td style="width: 5%; white-space: nowrap" align="right">
                            Dept
                        </td>
                        <td style="width: 30%; white-space: nowrap" >
                            <gw:list id="lstDept" styles='width:100%' onchange="" />
                        </td>
						
						<td style="width: 5%; white-space: nowrap">
                            <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Charger')">Charger</b>
                        </td>
                        <td colspan=6 >
                            <gw:textbox id="txtChargerPK" styles='width:100%;display:none' />
                            <gw:textbox id="txtChargerName" styles='width:100%' />
                        </td>
                    </tr>
					
					<tr style="width: 100%; white-space: nowrap">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Slip type
                        </td>
                        <td style="width: 30%" colspan=2 >
                            <gw:list id="lstSlipType" styles='width:100%' onchange="" />
                        </td>    						 
                        <td align="right" style="width: 5%">
                            <a title="Partner" onclick="OnPopUp('Partner')" href="#tips" style="color: #0000ff">
								Partner</a>
                        </td>
                        <td style="width: 65%; white-space: nowrap" colspan="8">
							<gw:textbox id="txtPartnerID" styles="width:30%;" />
                            <gw:textbox id="txtPartnerName" styles="width:70%;"  />
                            <gw:textbox id="txtPartnerPK" styles="display=none" />
                        </td>
                    </tr>
					
                    <tr style="width: 100%; height: 1%"> 
						<td style="width: 5%; white-space: nowrap" align="right">
                            <a title="Partner" onclick="OnPopUp('VALID')" href="#tips" style="color: #0000ff">
								Valid</a>
                        </td>
                        <td style="width: 30%; white-space: nowrap" colspan=2 >
                            <gw:datebox id="dtStartDate" lang="1" width="10%" nullaccept />
							~
							<gw:datebox id="dtEndDate" lang="1" width="10%" nullaccept />
                        </td>  
						
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Remark
                        </td>
                        <td style="width: 5%; white-space: nowrap" colspan="8">
                            <gw:textbox id="txtDesc" styles='width:100% ' />
                        </td>
                    </tr>
                     
                    <tr style="height: 1%">
                        <td colspan="13">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle('1')" />
                                    </td> 									
									 
									<td align="right" style="width: 5%; white-space: nowrap">
										 
									</td>
									<td style="width: 5%" align=center>
										<gw:icon id="idBtnUpdate" img="2" text="Update Price" styles='width:100%' onclick="OnProcess('UPDATE_PRICE')" />
									</td>
									<td align="left" style="width: 5%; white-space: nowrap">
										<gw:imgbtn img="excel" alt="Report" id="btnReport" onclick="OnPopUp('Report')" /> 
									</td>
									<td align="left" style="width: 5%; white-space: nowrap">
										<gw:list id="lstPercent" styles="width:70" />
									</td>
									<td align="left" style="width: 30%; white-space: nowrap">
										<gw:imgbtn id="btnProcess" img="process" alt="Set Data" onclick="OnProcess('PRICE')" />
									</td>
									<td align="right" style="width: 5%; white-space: nowrap">
										Item
									</td>
									<td style="width: 20%">
										<gw:textbox id="txtItem" styles="width:100%;"  onenterkey="OnSearch('Detail')" />
									</td>
									<td style="width: 1%" align="right">
										<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('Detail')" />
									</td>									
									<td style="width: 15%; white-space: nowrap" align="center"> 
										<gw:label id="lblRecord" styles="color: blue"></gw:label>
                                    </td>
									
									<td style="width: 1%">
                                        <gw:icon id="idGetFreeItem" img="2" text="ITEM" alt="Free Item" styles='width:100%'
                                            onclick="OnAddNew('ITEM')" />
                                    </td>
									<td style="width: 1%">
										<gw:imgbtn id="btnNewD" img="new" alt="New" text="New" onclick="OnAddNew('DETAIL')" />
									</td>
									
                                    
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 94%">
                        <td colspan="13">
                            <gw:grid id='grdDetail' 
								header='_pk|_master_pk|Seq|_tlg_it_item_pk|Item Code|Item Name|UOM|Internal Price|Tax(%)|_PARTNER_PK|_Partner ID|_Partner Name|_P/O Dept|Purchase Price|Remark|Percent'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|1|0|0|0|1|3|3|0|0|0|0|3|0|0' 
								check='|||||||||||||||' 
								editcol='0|0|1|0|0|0|0|1|1|0|0|0|1|1|1|0'
                                widths='0|0|800|0|1500|2500|800|1500|1200|0|2000|2500|1500|1500|1000|800' 
								sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnPopUp('Detail')" onafteredit="CheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------->
    <gw:textbox id="txtValueReturn" styles='width:100%;display:none' />
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <!--------------------------------------------------------->
</body>
</html>
