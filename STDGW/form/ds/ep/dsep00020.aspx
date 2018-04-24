 <!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Line W/I Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>
//-----------------------------------------------------
var flag;

var G_M_PK    = 0,
    G_DATE    = 1,
    G_SLIP_NO = 2,
    G_PARTNER = 3,
    G_LINE    = 4;		 

//===============================================================================================
var G1_TLG_PA_PACK_WI_M_PK      = 0,
    G1_TLG_PA_PACK_WI_D_PK      = 1,
    G1_SEQ                      = 2,
	G1_TLG_IT_ITEM_PK           = 3,
    G1_ITEM_CODE                = 4, 
	G1_ITEM_NAME                = 5,
    G1_WI_QTY                   = 6,
    G1_REMARK              		= 7;
        
var arr_FormatNumber = new Array();    
 //===============================================================================================
function OnToggle()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

 //===============================================================================================
function BodyInit()
 {
 	
    System.Translate(document);  // Translate to language session    
    
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtPartnerName.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
    
    BindingDataList();    
    //----------------------------
	if ( Number(txtMasterPK.text) > 0 )
	{
		OnToggle();
		flag = 'view' ;
        data_dsep00020_1.Call("SELECT");
	}
	else
	{	
    	OnAddNew('Master');
	}	
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     //----------------------------
     data = "<%=ESysLib.SetListDataSQL("SELECT pk ,line_id || ' - ' || line_name  FROM tlg_pb_line  WHERE del_if = 0  ORDER BY line_id" )%>";    
     lstLine.SetDataText(data);
	 	 
	 var ctr = grdDetail.GetGridControl(); 
    // ctr.ColFormat(G1_INS_QTY) = "#,###,###,###,###,###.##";	 
	    
     //arr_FormatNumber[G1_INS_QTY] = 2;                  
 }

 //==================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_dsep00020_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view";        
        break;  
        
        case 'Detail':
                var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
			    var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
			    if ( object != null )
			    {
                    var arrTemp;
                    for(var i = 0; i < object.length; i++)
                    {
                        arrTemp = object[i];
                        grdDetail.AddRow();
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1 );
	                    grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_PA_PACK_WI_M_PK, txtMasterPK.text);                        
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_IT_ITEM_PK, arrTemp[0]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[1]);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, arrTemp[2]);
                    }
			    }
        break;

        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];   
                            grdDetail.AddRow();                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	
							    	                                               
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK,   arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, arrTemp[2]);//item_name
							grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,       arrTemp[5]);//item_name	
																					
                            grdDetail.SetGridText( grdDetail.rows-1, G1_START_DT,  dtVoucherDate.value );//item_name	                             
                    }	
             }        
        break;                    
        
		case 'SO':
             var path = System.RootURL + '/form/fp/pw/fppw00031.aspx';
             var object = System.OpenModal( path ,1050 , 600 ,  'resizable:yes;status:yes',this);	 
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            
                            arrTemp = object[i]; 
							  
                            grdDetail.AddRow();                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text ); //master_pk	
							
							grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, 	grdDetail.rows-1 ); //master_pk	
                            														  	                                               
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SALE_ORDER_D_PK, arrTemp[6] );//item_pk	
							grdDetail.SetGridText( grdDetail.rows-1, G1_REF_NO,          arrTemp[3] );//item_name  
							    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK,   arrTemp[7]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE, arrTemp[8]);//item_name	
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME, arrTemp[9]);//item_name	
							grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,       arrTemp[10]);//item_name	
							   
                            grdDetail.SetGridText( grdDetail.rows-1, G1_INS_QTY,   arrTemp[11]);//item_name                         
                    }	
             }   
             
           if(txtMasterPK.text=="")
           {  
               var ref_no ="";
               var l_last_ref_no = "";
               
               if(grdDetail.rows > 1)
               {   
                  for(var i=1;i<grdDetail.rows;i++)
                  {
  	 		           if(l_last_ref_no!=grdDetail.GetGridData(i,G1_REF_NO)&&grdDetail.GetGridData(i,G1_REF_NO)!="")    
  	 		           {
  	 		                ref_no = ref_no + grdDetail.GetGridData(i,G1_REF_NO) + ',';
  	 		           } 
  	 		           l_last_ref_no = grdDetail.GetGridData(i,G1_REF_NO);
                  }
               }
               if(ref_no.length>1)
               {
                ref_no = ref_no.substring(0,ref_no.length-1);
                txtRefno.text = ref_no;
               } 
           }
	    break;
		
		             
    }
}  

//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_dsep00020.Call("SELECT");
        break;
    
        case 'grdMaster':
            if ( data_dsep00020_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_M_PK );
                    }
                    flag = 'view' ;
                    data_dsep00020_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, G_M_PK );
                }
                flag = 'view' ;
                data_dsep00020_1.Call("SELECT");
            }                     
        break;
        
        case 'grdDetail':            
            data_dsep00020_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_dsep00020_1": 
            if ( flag == 'save')
            {
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }
                            
        break;

        case "data_dsep00020_2":
            if ( grdDetail.rows > 1 )
            {
                    grdDetail.SetCellBgColor( 1, G1_ITEM_NAME, grdDetail.rows - 1, G1_ITEM_NAME, 0xCCFFFF ); 
                    grdDetail.SetCellBold( 1, G1_ITEM_CODE,     grdDetail.rows - 1, G1_ITEM_CODE,     true);          
                    grdDetail.SetCellBold( 1, G1_WI_QTY,     grdDetail.rows - 1, G1_WI_QTY,     true);  
            }         
        break;

        case 'pro_dsep00020':
            alert(txtReturnValue.text);
            OnSearch('grdMaster');
        break;   
        
        case 'pro_dsep00020_1':
            alert(txtReturnValue.text);
        break; 		
		 	            
   }            
}

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text = obj[2];
                txtStaffPK.text   = obj[0];
            }
        break;            
        
        case 'Line':
            var path = System.RootURL + '/form/fp/ab/fpab00200.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');            
        break;        
        
        case 'Project':
                var fpath  = System.RootURL + "/form/bd/dp/bddp00012.aspx";
                var oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
                if ( oValue != null )
                {
                    txtProjectPK.text = oValue[0]; 
                    txtProjectNM.text   = oValue[2];
                }
        break; 
        case 'Partner' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {
	            txtPartnerPK.text   = object[0];
                txtPartnerName.text = object[2];         
	         }
        break;                   				 	                	 
    }	       
}
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_dsep00020_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_dsep00020_2.Call();
        break;
    }
}
 
//=================================================================================

function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_dsep00020_1.StatusDelete();
                data_dsep00020_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_TLG_PA_PACK_WI_D_PK ) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                }    
            }            
        break;            

    }     
}
//=================================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}

//=================================================================================
function Validate()
{   
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData( i, G1_WI_QTY)) == 0 )
        {
            alert("Input wi qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//=================================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_WI_QTY )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
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
function OnPrint()
{      
	if( txtMasterPK.text != "" )
	{
		 var url =System.RootURL + '/reports/fp/pw/rpt_dsep00020.aspx?master_pk='+ txtMasterPK.text;			 
          window.open(url); 
 	}
	else
	{
		alert("Please, select one delivery voucher to print!");
	}	
}
//=================================================================================
</script>
<body>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_dsep00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2" function="<%=l_user%>lg_sel_dsep00020" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="txtSearch" />
					<input bind="txtItem01" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_dsep00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9" function="<%=l_user%>lg_sel_dsep00020_1"  procedure="<%=l_user%>lg_upd_dsep00020"> 
                <inout>                       
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtWi" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="txtRefNo" />
					 <inout  bind="lstLine" />
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="txtPartnerPK" />                                                                                    
                     <inout  bind="txtPartnerName" />                                                                                    
                     <inout  bind="txtRemark" />                                                                                      
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_dsep00020_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_dsep00020_2"   procedure="<%=l_user%>lg_upd_dsep00020_1"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" />
					<input bind="txtItem02" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dsep00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00020" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_dsep00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_dsep00020_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 85%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 5%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Search
                        </td>
                        <td style="width: 85%" colspan="1">
                            <gw:textbox id="txtSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
					<tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Item
                        </td>
                        <td style="width: 85%" colspan="1">
                            <gw:textbox id="txtItem01" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_pk|Slip Date|Slip No|Partner|Line'
                                format='0|4|0|0|0' aligns='0|0|0|0|0' check='||||' editcol='1|1|1|1|1' widths='0|1200|1000|0|1000'
                                sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 10%">
                            Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtWi" lang="1" />
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 30%" align="center">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Ref No
                        </td>
                        <td style="width: 28%" colspan="3">
                            <gw:textbox id="txtRefNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td colspan="9">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <a title="Charger" onclick="OnPopUp('Line')" href="#tips" style="color=#0000ff">Line
                            </a>
                        </td>
                        <td style="width: 20%" colspan="3">
                            <gw:list id="lstLine" styles="width: 100%" onchange="OnSearch('Master')" />
                        </td>
                        <td align="right">
                            <a title="Partner" onclick="OnPopUp('Partner')" href="#tips" style="color=#0000ff">Partner
                            </a>
                        </td>
                        <td style="width: 20%" colspan="11">
                            <gw:textbox id="txtPartnerPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtPartnerName" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Remark
                        </td>
                        <td style="width: 20%" colspan="14">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="14">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%" align="left">
                            <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td style="width: 5%">
							Item
                        </td>
                        <td style="width: 40%" align="right">
						 	<gw:textbox id="txtItem02" styles="width: 100%" onenterkey="OnSearch('grdDetail')" />
                        </td>                        
                        <td align="right" style="width: 42%">
                        </td>
                        <td align="right" style="width: 1%">
                            <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew('Detail')" />
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
        <tr style="height: 97%">
            <td colspan="14">
                <gw:grid id='grdDetail' header='_tlg_pa_pack_wi_m_pk|_tlg_pa_pack_wi_d_pk|Seq|_tlg_it_item_pk|Item Code|Item Name|W/I Qty|Remark'
                    format='0|0|0|0|0|0|1|0' 
					aligns='0|0|1|0|0|0|0|0' 
					check='|||||||' 
					editcol='0|0|1|0|0|0|1|1'
                    widths='0|0|600|0|1300|2000|1000|1000' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
</html>
