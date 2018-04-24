<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>PROMOTION RULE ENTRY</title>
</head>

<script type="text/javascript" language="javascript">
var flag;
					
var G0_MASTER_PK	= 0,
	G0_FR_DATE		= 1,
	G0_TO_DATE		= 2,	 
	G0_PRO_NAME	    = 3,
	G0_STATUS	    = 4;
	
var G1_PROMO_D_PK    	= 0,
    G1_PROMO_M_PK    	= 1,
	G1_SEQ 				= 2,
	G1_PROMO_TYPE       = 3,
	G1_ORD_ITEM_PK      = 4,
	G1_ORD_ITEM_CODE	= 5,
	G1_ORD_ITEM_NAME 	= 6,
    G1_ORD_QTY          = 7,
    G1_ORD_AMT          = 8,
	G1_PROMO_ITEM_PK    = 9,
	G1_PROMO_ITEM_CODE  = 10,
	G1_PROMO_ITEM_NAME  = 11,
	G1_PROMO_QTY        = 12,
    G1_PROMO_AMT        = 13,     	 	
    G1_PROMO_RATE       = 14,
    G1_REMARK           = 15;
        	
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

     data ="#1;1 QTY|#2;2 AMT|#3;3 RATE AMT|#4;4 RATE QTY|#5;5 QTY DISC AMT";
     grdDetail.SetComboFormat(G1_PROMO_TYPE,data);
	 	 	   
	 grdDetail.GetGridControl().ColFormat(G1_ORD_QTY)    = "###,###,###.##"; 
	 grdDetail.GetGridControl().ColFormat(G1_ORD_AMT)    = "###,###,###.##";
	 grdDetail.GetGridControl().ColFormat(G1_PROMO_QTY)  = "###,###,###.##"; 
	 grdDetail.GetGridControl().ColFormat(G1_PROMO_AMT)  = "###,###,###.##";  
	 grdDetail.GetGridControl().ColFormat(G1_PROMO_RATE) = "###,###,###.##"; 
	 
	 arr_FormatNumber[G1_ORD_QTY] = 2;
	 arr_FormatNumber[G1_ORD_AMT] = 2;
	 arr_FormatNumber[G1_PROMO_QTY]  = 2;
	 arr_FormatNumber[G1_PROMO_AMT]  = 2;
	 arr_FormatNumber[G1_PROMO_RATE] = 2;
}
 
//=================================================================================
function OnAddNew(pos)
{
	switch (pos)
	{
		case 'Master':
			if ( data_dsmt00030_1.GetStatus() != 20 )
		    {
		        data_dsmt00030_1.StatusInsert();
		        grdDetail.ClearData();
				
				txtProID.text   = '<< New Pro Code >>';
				txtProName.text = '<< New Pro Name >>';
				
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
						
			grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ,        grdDetail.rows-1 );
			grdDetail.SetGridText( grdDetail.rows-1, G1_PROMO_M_PK, txtMasterPK.text );
		break;
	}    
}
//=================================================================================
function OnSave(obj)
{ 
    if(obj == 'Master')
    {
        flag='save';
        data_dsmt00030_1.Call();
    }    
    else if(obj == 'Detail')
    {
        data_dsmt00030_2.Call();
    }
}
//=================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_dsmt00030': //SEARCH
            for ( var i=0; i<grdSearch.rows; i++)
            {
                    if ( grdSearch.GetGridData( i, G0_STATUS) == 2 )
                    { 
                        grdSearch.SetCellBgColor( i, G0_FR_DATE, i, G0_STATUS, 0xCCFFFF );
                    } 
					else if ( grdSearch.GetGridData( i, G0_STATUS) == 3 ) 
					{
						grdSearch.SetCellBgColor( i, G0_FR_DATE, i, G0_STATUS, 0xFFFFCC );
					}
					else if ( grdSearch.GetGridData( i, G0_STATUS) == 4 ) 
					{
						grdSearch.SetCellBgColor( i, G0_FR_DATE, i, G0_STATUS, 0xFFCCFF );
					}  
            }     
        break;
		
        case 'data_dsmt00030_1': //MASTER
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_PROMO_M_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_PROMO_M_PK, txtMasterPK.text);
                    }    
                }                
                OnSave('Detail');  
            } 
            else
            {
                data_dsmt00030_2.Call('SELECT'); 
            }    
        break;
        
		case 'data_dsmt00030_2':
			if ( grdDetail.rows > 1 )
			{
				grdDetail.SetCellBold( 1, G1_ORD_ITEM_CODE, grdDetail.rows - 1, G1_ORD_ITEM_CODE, true);
				grdDetail.SetCellBgColor( 1, G1_ORD_ITEM_CODE, grdDetail.rows - 1, G1_ORD_AMT, 0xCCFFFF );
				
				grdDetail.SetCellBold( 1, G1_PROMO_ITEM_CODE, grdDetail.rows - 1, G1_PROMO_ITEM_CODE, true);
				grdDetail.SetCellBgColor( 1, G1_PROMO_ITEM_CODE, grdDetail.rows - 1, G1_PROMO_RATE, 0xFFFFCC );				
			}
		break;
		
        case 'pro_dsmt00030': // SUBMIT
            alert(txtValueReturn.text);
			
			data_dsmt00030_1.Call('SELECT');			
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
                data_dsmt00030_1.StatusDelete();
                data_dsmt00030_1.Call();
            }   
        break;
 		
		case 'Detail':
			if ( grdDetail.GetGridData( grdDetail.row, G1_PROMO_D_PK ) == '' )
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
            data_dsmt00030.Call('SELECT');
        break;
		
        case 'Master':
			if ( grdSearch.row > 0 )
			{
            	txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G0_MASTER_PK);
			
           	 	data_dsmt00030_1.Call('SELECT');
			}	
        break;
		
		case 'Detail' :
			data_dsmt00030_2.Call('SELECT');
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
		        pro_dsmt00030.Call();
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
		
		case 'Detail':
			 var event_row  = event.row;
	         var event_col  = event.col;
	         
             if ( ( event_col == G1_ORD_ITEM_CODE || event_col == G1_ORD_ITEM_NAME ) && event_row != 0 )
             {
                   var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=Y||Y|||';
                   var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                   if ( object != null )
                   {
                            grdDetail.SetGridText( event_row, G1_ORD_ITEM_PK,   object[0] );
                            grdDetail.SetGridText( event_row, G1_ORD_ITEM_CODE, object[1] );
                            grdDetail.SetGridText( event_row, G1_ORD_ITEM_NAME, object[2] );
                   }                       
             }
			 else if ( ( event_col == G1_PROMO_ITEM_CODE || event_col == G1_PROMO_ITEM_NAME ) && event_row != 0 )
			 {
                   var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=Y||Y|||';
                   var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                   if ( object != null )
                   {
                            grdDetail.SetGridText( event_row, G1_PROMO_ITEM_PK,   object[0] );
                            grdDetail.SetGridText( event_row, G1_PROMO_ITEM_CODE, object[1] );
                            grdDetail.SetGridText( event_row, G1_PROMO_ITEM_NAME, object[2] );
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
         
   if ( col == G1_ORD_QTY || col == G1_ORD_AMT || col == G1_PROMO_QTY || col == G1_PROMO_AMT || col == G1_PROMO_RATE )
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
	if(col == G1_PROMO_TYPE)
	{
	    if(grdDetail.GetGridData(row,col) == 1) // Qty
	    { 
	        grdDetail.GetGridControl().Cell( 7, 0, G1_ORD_QTY, 0, G1_ORD_QTY ) = 0x3300cc;
	        grdDetail.GetGridControl().Cell( 7, 0, G1_PROMO_QTY, 0, G1_PROMO_QTY ) = 0x3300cc;
	        
	        grdDetail.GetGridControl().Cell( 7, 0, G1_ORD_AMT, 0, G1_ORD_AMT ) = 0x000000;
	        grdDetail.GetGridControl().Cell( 7, 0, G1_PROMO_AMT, 0, G1_PROMO_AMT ) = 0x000000;		        
	    }
	    else if(grdDetail.GetGridData(row,col) == 2) // Amt
	    {
	        grdDetail.GetGridControl().Cell( 7, 0, G1_ORD_QTY, 0, G1_ORD_QTY ) = 0x000000;
	        grdDetail.GetGridControl().Cell( 7, 0, G1_PROMO_QTY, 0, G1_PROMO_QTY ) = 0x000000;	 
	        
	        grdDetail.GetGridControl().Cell( 7, 0, G1_ORD_AMT, 0, G1_ORD_AMT ) = 0x3300cc;
	        grdDetail.GetGridControl().Cell( 7, 0, G1_PROMO_AMT, 0, G1_PROMO_AMT ) = 0x3300cc;	               
	    }    
	}
}	
//=================================================================================
</script>

<body>
    <!--============================================= Search =====================================-->
    <gw:data id="data_dsmt00030" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	id="2"	type="grid"	parameter="0,1"	function="<%=l_user%>lg_SEL_DSMT00030"	>	
				<input>
					<input  bind="dtSeachFrom" />
					<input  bind="dtSeachTo" />
					<input	bind="txtSearchPro"	/>
					<input  bind="txtSearchPartner" />							
					<input  bind="txtSearchItem" />
					<input	bind="lstStatus"	/>
				</input>	
				<output	bind="grdSearch"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Master =====================================-->
    <gw:data id="data_dsmt00030_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"	function="<%=l_user%>lg_sel_dsmt00030_1"	procedure="<%=l_user%>lg_UPD_dsmt00030_1">	
				<input>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="dtProFrom"	/>	
						<inout	bind="dtProTo"	/>
						<inout	bind="txtChargerPK"	/>	
						<inout	bind="txtChargerName"	/>											
						<inout	bind="lblStatus"	/>
						<inout	bind="txtProID"	/>												 						 
						<inout	bind="txtProName"	/>				 											 
						<inout	bind="txtPriorSeq"	/>	
						<inout  bind="txtDivisionPK" />	
						<inout  bind="txtDivisionName" />	
						<inout  bind="txtPartnerGroupPK" />		
						<inout  bind="txtPartnerGroupName" />	
						<inout  bind="txtPartnerPK" />	
						<inout  bind="txtPartnerName" />			
						<inout	bind="txtDesc"	/>					
				</input>
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Detail =====================================-->
    <gw:data id="data_dsmt00030_2" onreceive="OnDataReceive(this)">	
		<xml>									
			<dso id="3"	type="grid"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_dsmt00030_2" procedure="<%=l_user%>lg_UPD_dsmt00030_2">	
				<input	bind="grdDetail">					
					<input	bind="txtMasterPK"	/>	
				</input>	
				<output	bind="grdDetail"	/>	
			</dso>	
		</xml>	
	</gw:data>
    <!--============================================= Submit =====================================-->
    <gw:data id="pro_dsmt00030" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>lg_PRO_dsmt00030"> 
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
                <table id="LeftBottomTB" style="width: 100%; height: 100%">
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
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Pro
                        </td>
                        <td style="width: 95%" colspan="3">
                            <gw:textbox id="txtSearchPro" styles='width:100%' />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
					<tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Partner
                        </td>
                        <td style="width: 95%" colspan="3">
                            <gw:textbox id="txtSearchPartner" styles='width:100%' />
                        </td>
                        <td style="width: 5%" align="right">
                             
                        </td>
					 <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Item
                        </td>
                        <td style="width: 95%" colspan="3">
                            <gw:textbox id="txtSearchItem" styles='width:100%' />
                        </td>
                        <td style="width: 5%" align="right">
                             
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="5">
                            <gw:grid id='grdSearch' header='_PK|Fr Date|To Date|Pro Name|_Status' format='0|4|4|0|0' aligns='0|1|1|0|0'
                                check='||||' editcol='0|0|0|0|0' widths='0|1200|1200|1000|0' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 65%; height: 100%" align="center" valign="top" id="right">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="width: 100%; height: 1%">					 
                        <td style="width: 5%" align="right" >
                            Date
                        </td>						
                        <td style="width: 30%; white-space: nowrap">
                            <gw:datebox id="dtProFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtProTo" lang="1" width="10%" />
                        </td>						
						<td style="width: 5%; white-space: nowrap">
                            Prior Seq
                        </td>						
                        <td style="width: 10%; white-space: nowrap">
                            <gw:textbox id="txtPriorSeq" styles='width:70' /> 
                        </td>
						
                        <td align='center' colspan=2 >
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
					
                        <td style="width: 5%; white-space: nowrap"   >
                           Promo
                        </td>
						                        
                        <td style="width: 45%; white-space: nowrap" colspan=11  >
                            <gw:textbox id="txtProID" styles='width:30%' csstype="mandatory" /> 
							<gw:textbox id="txtProName" styles='width:70%' csstype="mandatory" /> 
                        </td>
						 
                                              
                    </tr>
					<tr style="width: 100%; height: 1%">
                        <td align="right">
                            Desc
                        </td>
                        <td style="width: 45%" colspan="3">
                            <gw:textbox id="txtDesc" styles='width:100% ' />
                        </td>
						
						<td style="width: 5%" >
                            <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Charger')">Charger</b>
                        </td>
                        <td align="right" style="width: 1%" colspan=6 >
							 <gw:textbox id="txtChargerPK" styles='width:100%;display:none' /> 
                             <gw:textbox id="txtChargerName" styles='width:100%' /> 
                        </td>  
						
                    </tr>
                    <tr style="width: 100%; height: 1%">
                        <td colspan="11">
                            <table style="width: 100%; height: 100%; background-color: #B4E7FF" >
								<tr style="width: 100%; height: 1%; white-space:nowrap">                                    
                                    <td style="width: 5%;white-space: nowrap" >
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Division')">Division</b>
                                    </td>
                                    <td style="width: 95%">
                                        <gw:textbox id="txtDivisionPK" styles='width:30%;display=none' />                                         
                                        <gw:textbox id="txtDivisionName" styles='width:100%'   />
                                    </td>
                                </tr>    
                                <tr style="width: 100%; height: 1%; white-space:nowrap">                                    
                                    <td style="width: 5%;white-space: nowrap" >
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('PartnerGroup')">P/Group</b>
                                    </td>
                                    <td style="width: 95%">
                                        <gw:textbox id="txtPartnerGroupPK" styles='width:30%;display=none' />                                         
                                        <gw:textbox id="txtPartnerGroupName" styles='width:100%'   />
                                    </td>
                                </tr>    
                                <tr style="width: 100%;white-space: nowrap" >                                    
                                    <td style="width: 5%;white-space: nowrap">
                                        <b style="color: #1b2ff2; cursor: hand;" onclick="OnPopUp('Partner')">Partner</b>
                                    </td>
                                    <td style="width: 95%">
                                        <gw:textbox id="txtPartnerPK" styles='width:30%;display=none' />                                         
                                        <gw:textbox id="txtPartnerName" styles='width:100%'   />
                                    </td>
                                </tr>                                
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="14">
                            <table style="width: 100%; height: 100%" border="0">
                                <tr>
                                    <td style="width: 97%; white-space: nowrap" align="left">
										<img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                			style="cursor: hand" onclick="OnToggle('1')" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap" align="center">
                                        <gw:imgbtn img="new" alt="Get Asset" id="btnNew2" onclick="OnAddNew('Detail')" />
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
                            <gw:grid id='grdDetail' 
								header='_PK|_PROMO_M_PK|Seq|Pro Type|_Ord_Item_PK|Ord Item Code|Ord Item Name|Ord Qty|Ord Amt|_Pro_Item_PK|Pro Item Code|Pro Item Name|Pro Qty|Pro Amt|Pro (%)|Remark'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|0|0|0|0|0|3|3|0|0|0|3|3|3|0'  
                                editcol='0|0|1|1|0|0|0|1|1|0|0|0|1|1|1|1' 
								widths='0|0|800|1500|0|1500|3000|1500|1500|0|1500|3000|1500|1500|1500|1500'
                                sorting='T' styles='width:100%; height:100%' oncelldblclick="OnPopUp('Detail')" onafteredit="CheckInput()" />
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
