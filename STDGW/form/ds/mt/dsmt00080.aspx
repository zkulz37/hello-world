<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>INCENTIVE RULE ENTRY</title>
</head>

<script type="text/javascript" language="javascript">
var flag;
var G_PK              = 0,
    G_VALID_FR_DATE   = 1,
    G_VALID_TO_DATE   = 2,
    G_SLIP_NO         = 3,
    G_FULL_NAME       = 4,
    G_STATUS          = 5;
     
var G1_DETAIL_PK    	    = 0,
    G1_TLG_MT_INCEN_M_PK    = 1,
	G1_TLG_IT_ITEMGRP_PK    = 2,
	G1_TLG_IT_ITEM_PK       = 3,
	G1_ITEM_CODE            = 4,
	G1_ITEM_NAME            = 5,
	G1_INCEN_RATE           = 6,
    G1_SALE_AMOUNT          = 7,
    G1_INCENT_AMOUNT        = 8,
    G1_REMARK               = 9;
        	
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
	txtEmpName.SetReadOnly(true);
	txtPartnerName.SetReadOnly(true);
	txtPartnerGroupName.SetReadOnly(true);
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
     
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   code, (code || ' ' || code_nm) code_nm FROM tlg_lg_code a, tlg_lg_code_group b WHERE a.tlg_lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGCM0130' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, ord" )%>" ; 
     grdSearch.SetComboFormat(1,data);    
     
	 grdDetail.GetGridControl().ColFormat(G1_INCEN_RATE)    = "###,###,###.#";    	 	 	   
	 grdDetail.GetGridControl().ColFormat(G1_INCENT_AMOUNT) = "###,###,###.##"; 
	 grdDetail.GetGridControl().ColFormat(G1_SALE_AMOUNT)   = "###,###,###.##"; 
	 
	 arr_FormatNumber[G1_INCEN_RATE]    = 1;
	 arr_FormatNumber[G1_INCENT_AMOUNT] = 2;
	 arr_FormatNumber[G1_SALE_AMOUNT]   = 2;
}
 
//=================================================================================
function OnAddNew(pos)
{
	switch (pos)
	{
		case 'Master':
			if ( data_DSMT00080_1.GetStatus() != 20 )
		    {
		        data_DSMT00080_1.StatusInsert();
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
		
		case 'Detail':
			grdDetail.AddRow();
						
			grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_MT_INCEN_M_PK, txtMasterPK.text );
		break;
	}    
}
//=================================================================================
function OnSave(obj)
{ 
    if(obj == 'Master')
    {
        flag='save';
        data_DSMT00080_1.Call();
    }    
    else if(obj == 'Detail')
    {
        data_DSMT00080_2.Call();
    }
}
//=================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_DSMT00080': //SEARCH  
            for( var i=0; i<grdSearch.rows; i++)
            {
                    if ( grdSearch.GetGridData( i, G_STATUS) == 2 )
                    { 
                        grdSearch.SetCellBgColor( i, G_VALID_FR_DATE, i, G_STATUS, 0xCCFFFF );
                    } 
					else if ( grdSearch.GetGridData( i, G_STATUS) == 3 ) 
					{
						grdSearch.SetCellBgColor( i, G_VALID_FR_DATE, i, G_STATUS, 0xFFFFCC );
					}
					else if ( grdSearch.GetGridData( i, G_STATUS) == 4 ) 
					{
						grdSearch.SetCellBgColor( i, G_VALID_FR_DATE, i, G_STATUS, 0xFFCCFF );
					}  
            }  
        break;
		
        case 'data_DSMT00080_1': //MASTER
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_TLG_MT_INCEN_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_TLG_MT_INCEN_M_PK, txtMasterPK.text);
                    }    
                }                
                OnSave('Detail');  
            } 
            else
            {
                data_DSMT00080_2.Call('SELECT'); 
            }    
        break;
        
		case 'data_DSMT00080_2':
			if ( grdDetail.rows > 1 )
			{
				grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);		
			}
		break;
		
        case 'pro_DSMT00080': // SUBMIT
            alert(txtValueReturn.text);
			
			data_DSMT00080_1.Call('SELECT');			
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
                data_DSMT00080_1.StatusDelete();
                data_DSMT00080_1.Call();
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
            data_DSMT00080.Call('SELECT');
        break;
		
        case 'Master':
			if ( grdSearch.row > 0 )
			{
            	txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_PK );
			
           	 	data_DSMT00080_1.Call('SELECT');
			}	
        break;
		
		case 'Detail' :
			data_DSMT00080_2.Call('SELECT');
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
		        pro_DSMT00080.Call();
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
		
 		case 'Emp' :
                 var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( obj != null )
	             {
	                txtEmpPK.text   = obj[0];
                    txtEmpName.text = obj[2];
                 }	
	    break;
	    		
		case 'Item':
                 var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y||Y|||';
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');  
                   if ( object != null )
                   {
                        for( var i=0; i < object.length; i++)	  
                        {	
                            var arrTemp = object[i];

                            grdDetail.AddRow();     
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_IT_ITEM_PK      , arrTemp[0] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_IT_ITEMGRP_PK   , arrTemp[3] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE           , arrTemp[1] );
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME           , arrTemp[2] );
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
         
   if ( col == G1_INCEN_RATE || col == G1_INCENT_AMOUNT || col == G1_SALE_AMOUNT )
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
		
		if ( col == G1_INCEN_RATE || col == G1_SALE_AMOUNT )
   		{
			var incent_amount = grdDetail.GetGridData( row, G1_INCEN_RATE ) * grdDetail.GetGridData( row, G1_SALE_AMOUNT ) / 100 ;
			grdDetail.SetGridText( row, G1_INCENT_AMOUNT, System.Round( incent_amount, arr_FormatNumber[col] )  );
		}					 
	}        
	
}	
//=================================================================================
</script>

<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_DSMT00080" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1"	function="<%=l_user%>lg_SEL_DSMT00080"	>	
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
    <gw:data id="data_DSMT00080_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"	function="<%=l_user%>lg_sel_DSMT00080_1"	procedure="<%=l_user%>lg_UPD_DSMT00080">	
				<input>	
                          <inout    bind="txtMasterPK"	/>
                          <inout    bind="txtSlipNo"	/>
                          <inout    bind="dtProFrom"	/>	
                          <inout    bind="dtProTo"	/>
                          <inout    bind="txtChargerPK"	/>	
                          <inout    bind="txtChargerName"	/>
                          <inout    bind="txtEmpPK"	/>	
                          <inout    bind="txtEmpName"	/>
                          <inout    bind="txtDesc"	/>											
                          <inout    bind="lblStatus"	/>	
                          <inout    bind="txtPartnerPK" />	
                          <inout    bind="txtPartnerName" />						
                          <inout    bind="txtDivisionPK" />	
                          <inout    bind="txtDivisionName" />	
                          <inout    bind="txtPartnerGroupPK" />		
                          <inout    bind="txtPartnerGroupName" />						
				</input>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_DSMT00080_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_DSMT00080_2" procedure="<%=l_user%>lg_UPD_DSMT00080_1">	
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Submit =====================================-->
    <gw:data id="pro_DSMT00080" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_DSMT00080"> 
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
                        <td style="width: 60%; white-space: nowrap" colspan="5">
                            <gw:textbox id="txtSlipNoSearch" styles='width:100%' onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="6">
                            <gw:grid id='grdSearch' header='_pk|Valid Fr Date|Valid To Date|Slip No|Full Name|_Status'
                                format='0|4|4|0|0|0' aligns='0|0|0|0|0|0' check='|||||' editcol='1|1|1|1|1|1'
                                widths='0|1200|1200|1000|1000|0' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" />
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
                        <td style="width: 30%; white-space: nowrap">
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
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Emp')">Emp</b>
                                    </td>
                                    <td style="width: 95%" colspan="3">
                                        <gw:textbox id="txtEmpPK" styles='width:100%;display:none' />
                                        <gw:textbox id="txtEmpName" styles='width:100%' />
                                    </td>
                                </tr>
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
                                    </td>
                                    <td style="width: 1%; white-space: nowrap" align="center">
                                        <gw:icon id="idBtnGetAsset" img="2" text="Item" styles='width:100%' onclick="OnPopUp('Item')" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap" align="center">
                                        <gw:imgbtn img="new" alt="Add new detail" id="btnNew2" onclick="OnAddNew('Detail')" />
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
                            <gw:grid id='grdDetail' header='_PK|_TLG_MT_INCEN_M_PK|_tlg_it_itemgrp_pk|_tlg_it_item_pk|Item Code|Item Name|Incent Rate|Sale Amount|Sale Qty|Remark'
                                format='0|0|0|0|0|0|1|1|1|0' 
								aligns='0|0|0|0|0|0|0|0|0|0' 
								check='|||||||||' 
								editcol='0|0|0|0|0|0|1|1|1|1'
                                widths='0|0|0|0|1500|2500|1200|1500|1500|1000' sorting='T' styles='width:100%; height:100%'
                                onafteredit="CheckInput()" />
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
