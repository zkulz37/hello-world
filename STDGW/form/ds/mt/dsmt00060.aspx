<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>SALE PRICE ENTRY</title>
</head>

<script type="text/javascript" language="javascript">
var flag;
var G_PK            = 0,
    G_SLIP_NO       = 1,
    G_PRICE_FR_DATE = 2,
    G_PRICE_TO_DATE = 3,
    G_PRICE_TYPE    = 4,
    G_STATUS        = 5; 

var G0_MASTER_PK	        = 0,
    G0_SLIP_NO  	        = 1,
	G0_FR_DATE		        = 2,
	G0_TO_DATE		        = 3,	 
	G0_CHARGER_PK           = 4,
	G0_FULL_NAME            = 5,
	G0_DESCRIPTION          = 6,
	G0_STATUS               = 7,
	G0_TCO_BUSPARTER_PK     = 8,
	G0_PARTNER_NAME         = 9,
	G0_TLG_MT_DIVISION_PK   = 10,
	G0_TLG_MT_DIVISION_NM   = 11,
	G0_TLG_MT_PA_GROUP_PK   = 12,
	G0_TLG_MT_PA_GROUP_NM   = 13,
	G0_PRICE_TYPE           = 14, 
	G0_CCY                  = 15;
	

var G1_DETAIL_PK    	        = 0,
    G1_TLG_MT_SALE_PRICE_M_PK   = 1,
	G1_SEQ                      = 2,
	G1_TLG_IT_ITEM_PK           = 3,
	G1_ITEM_CODE                = 4,
	G1_ITEM_NAME                = 5,
	G1_UNIT_PRICE               = 6,
    G1_DESCRIPTION              = 7;
        	
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
	txtPartnerGroupName.SetReadOnly(true);
	txtPartnerName.SetReadOnly(true);
	txtDivisionName.SetReadOnly(true);
	
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

     //data ="#1;QTY|#2;AMT|#3;RATE AMT|#3;RATE QTY";
     //grdDetail.SetComboFormat(G1_PROMO_TYPE,data);
	 	 	   
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>";    
     lstPriceType.SetDataText(data); 
     
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   code, (code || ' ' || code_nm) code_nm FROM tlg_lg_code a, tlg_lg_code_group b WHERE a.tlg_lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGCM0130' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, ord" )%>" ; 
     grdSearch.SetComboFormat(G_PRICE_TYPE,data);      

     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCurrency.SetDataText(data);     
        	 	 	   
	 grdDetail.GetGridControl().ColFormat(G1_UNIT_PRICE)    = "###,###,###"; 
	 
	 arr_FormatNumber[G1_UNIT_PRICE] = 2;
}
 
//=================================================================================
function OnAddNew(pos)
{
	switch (pos)
	{
		case 'Master':
			if ( data_DSMT00060_1.GetStatus() != 20 )
		    {
		        data_DSMT00060_1.StatusInsert();
		        grdDetail.ClearData();
				
				txtChargerName.text = "<%=Session("USER_NAME")%>";
                txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
		        //----------------     
		        flag = "view";                          
		    }
		    else
		    {
		        alert("Already add new. Pls input data !!!");
		    }			
		break;
	}    
}
//=================================================================================
function OnSave(obj)
{ 
    if(obj == 'Master')
    {
        flag='save';
        data_DSMT00060_1.Call();
    }    
    else if(obj == 'Detail')
    {
        data_DSMT00060_2.Call();
    }
}
//=================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_DSMT00060': //SEARCH  
            for( var i=0; i<grdSearch.rows; i++)
            {
                    if ( grdSearch.GetGridData( i, G_STATUS) == 2 )
                    { 
                        grdSearch.SetCellBgColor( i, G_PRICE_FR_DATE, i, G_STATUS, 0xCCFFFF );
                    } 
					else if ( grdSearch.GetGridData( i, G_STATUS) == 3 ) 
					{
						grdSearch.SetCellBgColor( i, G_PRICE_FR_DATE, i, G_STATUS, 0xFFFFCC );
					}
					else if ( grdSearch.GetGridData( i, G_STATUS) == 4 ) 
					{
						grdSearch.SetCellBgColor( i, G_PRICE_FR_DATE, i, G_STATUS, 0xFFCCFF );
					}  
            }     
        break;
		
        case 'data_DSMT00060_1': //MASTER
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_TLG_MT_SALE_PRICE_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_TLG_MT_SALE_PRICE_M_PK, txtMasterPK.text);
                    }    
                }                
                OnSave('Detail');  
            } 
            else
            {
                data_DSMT00060_2.Call('SELECT'); 
            }    
        break;
        
		case 'data_DSMT00060_2':
			if ( grdDetail.rows > 1 )
			{
				grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);		
			}
		break;
		
        case 'pro_DSMT00060': // SUBMIT
            alert(txtValueReturn.text);
			
			data_DSMT00060_1.Call('SELECT');			
        break;
        
        case 'pro_DSMT00060_1': // COPY
            alert(txtValueReturn.text);
			
			data_DSMT00060.Call('SELECT');			
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
                data_DSMT00060_1.StatusDelete();
                data_DSMT00060_1.Call();
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
            data_DSMT00060.Call('SELECT');
        break;
		
        case 'Master':
			if ( grdSearch.row > 0 )
			{
            	txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G0_MASTER_PK);
			
           	 	data_DSMT00060_1.Call('SELECT');
			}	
        break;
		
		case 'Detail' :
			data_DSMT00060_2.Call('SELECT');
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
		        pro_DSMT00060.Call();
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
		        	pro_DSMT00060_1.Call();
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
        case 'Partner':
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerPK.text   = object[0];	             
                txtPartnerName.text = object[2];
	         }
        break;           
		
		case 'Division':
             var path = System.RootURL + "/form/fp/ab/fpab00610.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtDivisionPK.text   = object[0];
                txtDivisionName.text = object[2];
	         }
        break; 
		  
		case 'PartnerGroup':
             var path = System.RootURL + "/form/fp/ab/fpab00620.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerGroupPK.text   = object[0];
                txtPartnerGroupName.text = object[2];
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
		
		case 'Item':
                 var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');  
                   if ( object != null )
                   {
                        for( var i=0; i < object.length; i++)	  
                        {	
                            var arrTemp = object[i];
                            grdDetail.AddRow();     
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,   grdDetail.rows-1 );	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_IT_ITEM_PK,   arrTemp[0] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[1] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, arrTemp[2] );
                        }		
                   }  
		break;
	    			 
    }	       
}

 //=================================================================================================
 function CheckInput()
 {   
   var row, col;
   
   row = event.row;
   col = event.col;
         
   if ( col == G1_UNIT_PRICE)
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
//=================================================================================
</script>

<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_DSMT00060" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1"	function="<%=l_user%>lg_SEL_DSMT00060"	>	
				<input>
					<input  bind="dtSeachFrom" />
					<input  bind="dtSeachTo" />
					<input	bind="lstStatus"	/>
					<input	bind="txtSlipNoSearch"	/>	
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_DSMT00060_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"	function="<%=l_user%>lg_sel_DSMT00060_1"	procedure="<%=l_user%>lg_UPD_DSMT00060">	
				<input>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="dtProFrom"	/>	
						<inout	bind="dtProTo"	/>
						<inout	bind="txtChargerPK"	/>	
						<inout	bind="txtChargerName"	/>
						<inout	bind="txtDesc"	/>											
						<inout	bind="lblStatus"	/>	
						<inout  bind="txtPartnerPK" />	
						<inout  bind="txtPartnerName" />						
						<inout  bind="txtDivisionPK" />	
						<inout  bind="txtDivisionName" />	
						<inout  bind="txtPartnerGroupPK" />		
						<inout  bind="txtPartnerGroupName" />	
			            <inout  bind="lstPriceType" />
			            <inout  bind="lstCurrency" />							
				</input>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_DSMT00060_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_DSMT00060_2" procedure="<%=l_user%>lg_UPD_DSMT00060_1">	
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Submit =====================================-->
    <gw:data id="pro_DSMT00060" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_DSMT00060"> 
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
    <gw:data id="pro_DSMT00060_1" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_DSMT00060_1"> 
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
            <td style="width: 35%; height: 100%" id="left">
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
                        <td style="width: 35%" colspan="3">
                            <gw:list id="lstStatus" styles="width:100%" onchange="OnSearch('grdSearch')" />
                            <td style="width: 5%" align="right">
                                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdSearch')" />
                            </td>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Slip No
                        </td>
                        <td style="width: 60%; white-space: nowrap">
                            <gw:textbox id="txtSlipNoSearch" styles='width:100%' onenterkey="OnSearch('grdSearch')" />
                        </td>
						<td style="width: 5%; white-space: nowrap" align="right" colspan="3">
							<gw:icon id="idBtnCopy" img="2" text="Copy" styles='width:100%' onclick="OnProcess('Copy')" />
						</td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="6">
                            <gw:grid id='grdSearch' header='_PK|Slip No|Price Fr Date|Price To Date|Price Type|_Status'
                                format='0|0|4|4|0|0' aligns='0|0|1|1|0|0' check='||||' editcol='1|1|1|1|1|1' widths='0|1000|1200|1200|1000|0'
                                sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 65%; height: 100%" align="center" valign="top" id="right">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="width: 100%; height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:datebox id="dtProFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtProTo" lang="1" width="10%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:textbox id="txtSlipNo" styles='width:100%' />
                        </td>
                        <td align='center' colspan="2">
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
                    <tr style="width: 100%; height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Charger')">Charger</b>
                        </td>
                        <td>
                            <gw:textbox id="txtChargerPK" styles='width:100%;display:none' />
                            <gw:textbox id="txtChargerName" styles='width:100%' />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Desc
                        </td>
                        <td style="width: 5%; white-space: nowrap" colspan="7">
                            <gw:textbox id="txtDesc" styles='width:100% ' />
                        </td>
                    </tr>
                    <tr style="width: 100%; height: 1%">
                        <td colspan="11">
                            <table style="width: 100%; height: 100%; background-color: #B4E7FF" border="0">
                                <tr style="width: 100%; height: 1%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Division')">Division</b>
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtDivisionPK" styles='width:30%;display=none' />
                                        <gw:textbox id="txtDivisionName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="width: 100%; height: 1%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('PartnerGroup')">P/Group</b>
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtPartnerGroupPK" styles='width:30%;display=none' />
                                        <gw:textbox id="txtPartnerGroupName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="width: 100%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Partner')">Partner</b>
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtPartnerPK" styles='width:30%;display=none' />
                                        <gw:textbox id="txtPartnerName" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="width: 100%; white-space: nowrap">
                                    <td style="width: 5%; white-space: nowrap">
                                        Price type
                                    </td>
                                    <td style="width: 45%">
                                        <gw:list id="lstPriceType" styles='width:100%' onchange="" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap">
                                        CCY
                                    </td>
                                    <td style="width: 45%">
                                        <gw:list id="lstCurrency" styles='width:100%' onchange="" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="11">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td style="width: 97%; white-space: nowrap" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle('1')" />
                                    </td> <td style="width: 1%; white-space: nowrap" align="center">
                                      
                                    </td>
                                    <td style="width: 1%; white-space: nowrap" align="center">
                                        <gw:imgbtn img="new" alt="Get Asset" id="btnNew2" onclick="OnPopUp('Item')" />
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
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_pk|_tlg_mt_sale_price_m_pk|Seq|_tlg_it_item_pk|Item Code|Item Name|Unit Price|Description'
                                format='0|0|0|0|0|0|1|0' aligns='0|0|1|0|0|0|0|0' check='|||||||' editcol='1|1|1|1|1|1|1|1'
                                widths='0|0|500|0|1500|3000|2000|1000' sorting='T' styles='width:100%; height:100%'
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
