<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">
var Insert      = 'F';
var Update      = 'F';
var Delete    = 'F';
function BodyInit()
{

    BindingDataList();
    lstCtrl1.Value="1";
    //OnSearch();
    datTCode_MST.Call("SELECT");
}
function BindingDataList()
{
    System.Translate(document);
    var ls_Company   = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_Control = "<%=ESysLib.SetListDataSQL("select pk , ITEM_NM from TAC_ABITEM where del_if = 0") %>" + "1||";
    var ls_DataType = "<%=ESysLib.SetListDataSQL("SELECT B.code, B.CODE_NM from TAC_COMMCODE_MASTER a, TAC_COMMCODE_DETAIL b where B.TAC_COMMCODE_MASTER_PK = A.PK AND id = 'GFNT0001'") %>";
    
    
    //lstCtrl1.ClearData();
    lstCompany.SetDataText(ls_Company);
    lstCtrl1.SetDataText(ls_Control);
    
    lstCtrl2.SetDataText(ls_Control);
    lstCtrl3.SetDataText(ls_Control);
    lstCtrl4.SetDataText(ls_Control);
    lstCtrl5.SetDataText(ls_Control);
    lstCtrl6.SetDataText(ls_Control);
    lstCtrl7.SetDataText(ls_Control);
    lstCtrl8.SetDataText(ls_Control);
    lstCtrl9.SetDataText(ls_Control);
    lstCtrl10.SetDataText(ls_Control);
    lstCtrl11.SetDataText(ls_Control);
    lstCtrl12.SetDataText(ls_Control);
    lstCtrl13.SetDataText(ls_Control);
    lstCtrl14.SetDataText(ls_Control);
    lstCtrl15.SetDataText(ls_Control);
    lstCtrl16.SetDataText(ls_Control);
    lstCtrl17.SetDataText(ls_Control);
    lstCtrl18.SetDataText(ls_Control);
    lstCtrl19.SetDataText(ls_Control);
    lstCtrl20.SetDataText(ls_Control);
    
    
    lstData1.SetDataText(ls_DataType);
    lstData2.SetDataText(ls_DataType);
    lstData3.SetDataText(ls_DataType);
    lstData4.SetDataText(ls_DataType);
    lstData5.SetDataText(ls_DataType);
    lstData6.SetDataText(ls_DataType);
    lstData7.SetDataText(ls_DataType);
    lstData8.SetDataText(ls_DataType);
    lstData9.SetDataText(ls_DataType);
    lstData10.SetDataText(ls_DataType);
    lstData11.SetDataText(ls_DataType);
    lstData12.SetDataText(ls_DataType);
    lstData13.SetDataText(ls_DataType);
    lstData14.SetDataText(ls_DataType);
    lstData15.SetDataText(ls_DataType);
    lstData16.SetDataText(ls_DataType);
    lstData17.SetDataText(ls_DataType);
    lstData18.SetDataText(ls_DataType);
    lstData19.SetDataText(ls_DataType);
    lstData20.SetDataText(ls_DataType);
    
    
    
}
function OnAddnew()
{
   // datCode_Ctrl_Grp.StatusInsert();
   
    // if(txtIDUpper.text== "" && txtUpper.text == "")
    if(txttac_ctrlgrp_pk.GetData() == "")
    {
		alert('Please Select Upper Account Code!!!'+'\n'+' Yêu cầu nhập tài khoản cấp cha!!!');
	}
	
	else
	    {
	    Insert   = 'T';
       
	      txtIDUpper.SetDataText(txtID.text);
	      txtUpper.SetDataText(txtIDr.text);
	      var paren_pk=txttac_ctrlgrp_pk.text;
	      var company_pk  =  lstCompany.GetData();
	      
	      datCode_Ctrl_Grp.StatusInsert();
        
	      txtP_PK.SetDataText(paren_pk);
	      
	      txttac_ctrlgrp_parent_pk.SetDataText(paren_pk);
	      
	     
	    lstCtrl1.value='1';
	    
        lstCtrl2.value='1';
       
        lstCtrl3.value='1';
        lstCtrl4.value='1';
        lstCtrl5.value='1';
        lstCtrl6.value='1';
        lstCtrl7.value='1';
        lstCtrl8.value='1';
        lstCtrl9.value='1';
        lstCtrl10.value='1';
        lstCtrl11.value='1';
        lstCtrl12.value='1';
        lstCtrl13.value='1';
        lstCtrl14.value='1';
        lstCtrl15.value='1';
        lstCtrl16.value='1';
        lstCtrl17.value='1';
        lstCtrl18.value='1';
        lstCtrl19.value='1';
        lstCtrl20.value='1';
    
        lstCtrl2.SetEnable(false);
        lstCtrl3.SetEnable(false);
        lstCtrl4.SetEnable(false);
        lstCtrl5.SetEnable(false);
        lstCtrl6.SetEnable(false);   
        lstCtrl7.SetEnable(false);
         lstCtrl8.SetEnable(false);
          lstCtrl9.SetEnable(false);
           lstCtrl10.SetEnable(false);
            lstCtrl11.SetEnable(false);
             lstCtrl12.SetEnable(false);
              lstCtrl13.SetEnable(false);
               lstCtrl14.SetEnable(false);
                lstCtrl15.SetEnable(false);
                 lstCtrl16.SetEnable(false);
                  lstCtrl17.SetEnable(false);
                   lstCtrl18.SetEnable(false);
                    lstCtrl19.SetEnable(false);
                     lstCtrl20.SetEnable(false);
                      
       
	    }
	    
	     
	     
	   
}
function OnSearch()
{
   
        datTCode_MST.Call("SELECT");
    
	
} 
function CtrlChange()
{
    if(lstCtrl1.GetData() !='')
    {
        lstCtrl2.SetEnable(true);
    }
    if(lstCtrl2.GetData() !='')
    {
        
        lstCtrl3.SetEnable(true);
    }
    if(lstCtrl3.GetData() !='')
    {
        lstCtrl4.SetEnable(true);
    }
    if(lstCtrl4.GetData() !='')
    {
        lstCtrl5.SetEnable(true);
    }
    if(lstCtrl5.GetData() !='')
    {
        lstCtrl6.SetEnable(true);
    }
    if(lstCtrl6.GetData() !='')
    {
        lstCtrl7.SetEnable(true);
    }
    if(lstCtrl7.GetData() !='')
    {
        lstCtrl8.SetEnable(true);
    }
    if(lstCtrl8.GetData() !='')
    {
        lstCtrl9.SetEnable(true);
    }
    if(lstCtrl9.GetData() !='')
    {
        lstCtrl10.SetEnable(true);
    }
    if(lstCtrl10.GetData() !='')
    {
        lstCtrl11.SetEnable(true);
    }
    if(lstCtrl11.GetData() !='')
    {
        lstCtrl12.SetEnable(true);
    }
    if(lstCtrl12.GetData() !='')
    {
        lstCtrl13.SetEnable(true);
    }
    if(lstCtrl13.GetData() !='')
    {
        lstCtrl14.SetEnable(true);
    }
    if(lstCtrl14.GetData() !='')
    {
        lstCtrl15.SetEnable(true);
    }
    if(lstCtrl15.GetData() !='')
    {
        lstCtrl16.SetEnable(true);
    }
    if(lstCtrl16.GetData() !='')
    {
        lstCtrl17.SetEnable(true);
    }
    if(lstCtrl17.GetData() !='')
    {
        lstCtrl18.SetEnable(true);
    }
    if(lstCtrl18.GetData() !='')
    {
        lstCtrl19.SetEnable(true);
    }
    if(lstCtrl19.GetData() !='')
    {
        lstCtrl20.SetEnable(true);
    }
  
}
function OnSave()
{   
    
   datCode_Ctrl_Grp.Call();
   //Update = 'T';
   //datCode_Ctrl_Grp.StatusUpdate();
  
}
function  OnPopUp(index)
 {
            var index;
            var path = System.RootURL + '/form/gf/ac/gfac00030.aspx';
		    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
		         strcontrolreturn = object[1];
                indexControl = index;
		        if (object[0] == 1)
                
                {                    
                    datGetNewControl.Call();
                    
                }            
                else
                {
                   switch(index)
                   {
                        case 1:
                            lstCtrl1.value = strcontrolreturn; 
                        break;
                        case 2:
                            lstCtrl2.value = strcontrolreturn;
                        break;
                        case 3:
                            lstCtrl3.value = strcontrolreturn; 
                        break;
                        case 4:
                            lstCtrl4.value = strcontrolreturn; 
                        break; 
                        case 5:
                            lstCtrl5.value = strcontrolreturn;
                        break;
                        case 6:
                            lstCtrl6.value = strcontrolreturn; 
                        break;
                        case 7:
                            lstCtrl7.value = strcontrolreturn; 
                        break 
                        case 8:
                            lstCtrl8.value = strcontrolreturn; 
                        break
                        case 9:
                            lstCtrl9.value = strcontrolreturn; 
                        break;
                        case 10:
                            lstCtrl10.value = strcontrolreturn; 
                        break;
                        case 11:
                            lstCtrl11.value = strcontrolreturn; 
                        break;
                        case 12:
                            lstCtrl2.value = strcontrolreturn; 
                        break;
                        case 13:
                            lstCtrl13.value = strcontrolreturn; 
                        break;
                        case 14:
                            lstCtrl14.value = strcontrolreturn; 
                        break;
                        case 15:
                            lstCtrl15.value = strcontrolreturn; 
                        break;
                        case 16:
                            lstCtrl16.value = strcontrolreturn; 
                        break;
                        case 17:
                            lstCtrl17.value = strcontrolreturn; 
                        break;
                        case 18:
                            lstCtrl18.value = strcontrolreturn; 
                        break;
                        case 19:
                            lstCtrl19.value = strcontrolreturn; 
                        break;
                        case 20:
                            lstCtrl20.value = strcontrolreturn;
                        break;
                   }
                    
                }
                    
		     } 
}      
//---------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    var strdata = txtControlTemp.text;

    if(obj.id == 'datCode_Ctrl_Grp')
    {
        if((Insert=='T') || (Delete=='T') || (Update=='T'))
        {
           
            if(Delete=='T')
            {
                txtIDUpper.text = '';
                txtUpper.text = '';
               
            }
          
           
                datTCode_MST.Call("SELECT"); 
                Insert = 'F';
                Delete = 'F';
           
        }
        else
        {
            datCode_uMST.Call();
        }   
    }
    else if(obj.id == 'datGetNewControl')
    {
           
        switch(indexControl)
        {
            case 1:
                lstCtrl1.SetDataText(strdata);
                lstCtrl1.value = strcontrolreturn;
            break;
            case 2:
                lstCtrl2.SetDataText(strdata);
                lstCtrl2.value = strcontrolreturn;
            break;
            case 3:
                lstCtrl3.SetDataText(strdata);
                lstCtrl3.value = strcontrolreturn;
            break;
            case 4:
                lstCtrl4.SetDataText(strdata);
                lstCtrl4.value = strcontrolreturn;
            break;
            case 5:
                lstCtrl5.SetDataText(strdata);
                lstCtrl5.value = strcontrolreturn;
            break;
            case 6:
                lstCtrl6.SetDataText(strdata);
                lstCtrl6.value = strcontrolreturn;
            break;
            case 7:
                lstCtrl7.SetDataText(strdata);
                lstCtrl7.value = strcontrolreturn;
            break;
            case 8:
                lstCtrl8.SetDataText(strdata);
                lstCtrl8.value = strcontrolreturn;
            break;
            case 9:
                lstCtrl9.SetDataText(strdata);
                lstCtrl9.value = strcontrolreturn;
            break;
            case 10:
                lstCtrl10.SetDataText(strdata);
                lstCtrl10.value = strcontrolreturn;
            break;
            case 11:
                lstCtrl11.SetDataText(strdata);
                lstCtrl11.value = strcontrolreturn;
            break;
            case 12:
                lstCtrl12.SetDataText(strdata);
                lstCtrl12.value = strcontrolreturn;
            break;
            case 13:
                lstCtrl13.SetDataText(strdata);
                lstCtrl13.value = strcontrolreturn;
            break;
            case 14:
                lstCtrl14.SetDataText(strdata);
                lstCtrl14.value = strcontrolreturn;
            break;
            case 15:
                lstCtrl15.SetDataText(strdata);
                lstCtrl15.value = strcontrolreturn;
            break;
            case 16:
                lstCtrl16.SetDataText(strdata);
                lstCtrl16.value = strcontrolreturn;
            break;
            case 17:
                lstCtrl17.SetDataText(strdata);
                lstCtrl17.value = strcontrolreturn;
            break;
            case 18:
                lstCtrl18.SetDataText(strdata);
                lstCtrl18.value = strcontrolreturn;
            break;
            case 19:
                lstCtrl19.SetDataText(strdata);
                lstCtrl19.value = strcontrolreturn;
            break;
            case 20:
                lstCtrl20.SetDataText(strdata);
                lstCtrl20.value = strcontrolreturn;
            break;
        }
        
    }
    
  
 
}
function OnDelete()
{
    if (txttac_ctrlgrp_pk.GetData() == "")
    {
	    alert('Please select account code to delete!!!'+'\n'+'Yêu cầu lựa chọn tài khoản cần xóa!!!');
	    return;
	}
    else
    {
	    if (confirm('  Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa tài khoản này?'))
	    {
	        Delete = 'T';
	        datCode_Ctrl_Grp.StatusDelete();
		    datCode_Ctrl_Grp.Call();
		}
    }
}
function treeItemOnclick()
 {
    
    
	var obj = event.srcElement.GetCurrentNode();
	
	//txtpPKSave.text = obj.parentNode.parentNode.oid;
	//txtPKSave.SetDataText( obj.oid );
    txttac_ctrlgrp_pk.SetDataText( obj.oid );
	
	
	datCode_Ctrl_Grp.Call('SELECT');
	//datCode_uMST.Call("SELECT");
 }

</script>
     
    <body>
    <gw:data id="datTCode_MST" > 
    <xml> 
        <dso id="1" type="tree" function="acnt.sp_sel_tcode_master" > 
            <input  >
                <input bind="txtGroup"/>
                <input bind="lstCompany" />
                
            </input>
            <output bind="treMST" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------------------------------------>
<gw:data id="datGetNewControl" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="acnt.sp_sel_new_control" > 
                <input> 
                    <input bind="txtControlID" /> 
                </input>
	           <output>
	                <output bind="txtControlTemp" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
<!------------------------------------------------------------------------------------------------------->
<gw:data id="datCode_Ctrl_Grp" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64"  function="acnt.sp_sel_ctrgrp" procedure="acnt.sp_upd_ctrgrp">
            <inout>
                <inout  bind="txttac_ctrlgrp_pk"/>
                <inout  bind="txtID"/>
                <inout  bind="txttac_ctrlgrp_parent_pk"/>
                <inout  bind="lstCompany" />
                <inout  bind="txtIDr" />
                
                <inout  bind="lstCtrl1" />
                <inout  bind="lstCtrl2" />
                <inout  bind="lstCtrl3" />
                <inout  bind="lstCtrl4" />
                <inout  bind="lstCtrl5" />
                <inout  bind="lstCtrl6" />
                <inout  bind="lstCtrl7" />
                <inout  bind="lstCtrl8" />
                <inout  bind="lstCtrl9" />
                <inout  bind="lstCtrl10" />                
                <inout  bind="lstCtrl11"/>
                <inout  bind="lstCtrl12" />
                <inout  bind="lstCtrl13" />
                <inout  bind="lstCtrl14" />
                <inout  bind="lstCtrl15" />
                <inout  bind="lstCtrl16" />
                <inout  bind="lstCtrl17" />
                <inout  bind="lstCtrl18" />
                <inout  bind="lstCtrl19" />
                <inout  bind="lstCtrl20" />
                
                <inout  bind="lstData1" />
                <inout  bind="lstData2" />
                <inout  bind="lstData3" />
                <inout  bind="lstData4" />
                <inout  bind="lstData5" />
                <inout  bind="lstData6" />
                <inout  bind="lstData7" />
                <inout  bind="lstData8" />
                <inout  bind="lstData9" />
                <inout  bind="lstData10" />                
                <inout  bind="lstData11"/>
                <inout  bind="lstData12" />
                <inout  bind="lstData13" />
                <inout  bind="lstData14" />
                <inout  bind="lstData15" />
                <inout  bind="lstData16" />
                <inout  bind="lstData17" />
                <inout  bind="lstData18" />
                <inout  bind="lstData19" />
                <inout  bind="lstData20" />
                
                <inout  bind="chkSYS1" />
                <inout  bind="chkSYS2" />
                <inout  bind="chkSYS3" />
                <inout  bind="chkSYS4" />
                <inout  bind="chkSYS5" />
                <inout  bind="chkSYS6" />
                <inout  bind="chkSYS7" />
                <inout  bind="chkSYS8" />
                <inout  bind="chkSYS9" />
                <inout  bind="chkSYS10" />                
                <inout  bind="chkSYS11"/>
                <inout  bind="chkSYS12" />
                <inout  bind="chkSYS13" />
                <inout  bind="chkSYS14" />
                <inout  bind="chkSYS15" />
                <inout  bind="chkSYS16" />
                <inout  bind="chkSYS17" />
                <inout  bind="chkSYS18" />
                <inout  bind="chkSYS19" />
                <inout  bind="chkSYS20" />
                
            </inout>
        </dso>
    </xml>
</gw:data>
<!------------------------------------------------------------------------------------------------------->
<gw:data id="datCode_uMST" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="3" type="process" procedure="acnt.sp_control_group_master" >
            <input>
                <input  bind="txttac_ctrlgrp_pk" />
            
            </input>
            <output>
                <output  bind="txttac_ctrlgrp_parent_pk" />
                <output  bind="txtIDUpper" />
                <output  bind="txtUpper" />                              
            </output>
        </dso>                    
    </xml>
</gw:data>
<!------------------------------------------------------------------------------------------------------->
    <table  width="100%" cellpadding="0" cellspacing="0" border="1">
	    <tr>
		    <td width="20%">
						    <!-- Table1 contain master buttons and text box -->
						    <table id="LeftTopTB"  width="100%">
							    <tr>
    								
								    <td width="30%">
									    <table style="width:100%">
									        <tr>
									        <td align="right" width="5%">Group</td>
									        <td style="width:95%">
									            <gw:textbox id="txtGroup" styles='width:100%' />
    									        
									        </td>

									        <td ><gw:imgBtn id="txtSearch" img="search" text="Search" onclick="OnSearch()"/></td>
									        </tr>
									    </table>						
								    </td>
    								
    							
							    </tr>
						    </table>
						    <!-- End of Table1--->
		    </td>
		    <td width="80%">
					    <!-- Table2 contain detail buttons and text box -->
					    
					    <table id="RightTopTB" style="width:100%" >
						    <tr>
						        <td align="right" style="width:13%">Company</td>
    							<td style="width:52%"><gw:list id="lstCompany" styles="width:100%;" /></td>
    							
							    <td width="35%" ></td>
							    <td ><gw:imgBtn id="ibtnReset" img="new" alt="new"	onclick="OnAddnew()"  	/></td>
							    
    						    <td ><gw:imgBtn id="ibtnDelete" img="delete" alt="delete" 	onclick="OnDelete()" 	 /></td>  
							    <td ><gw:imgBtn id="ibtnUpdate" img="save" alt="save" 	onclick="OnSave()" 	 /></td>
							    		
    			
    											
						    </tr>							
    						
					    </table>
					    <!-- End of Table2 -->					
		    </td>
	    </tr>
	    <tr >
	    <!-- Tree view --> 
	    <td  width="20%" valign="top">		
		      <table   width="100%" height="470">		 
			    <tr  >
				    <td height="100%"  >
					    <!-- Master Grid Control here. Remember add this function oncellclick="RowClick()"--> 
						    <gw:tree  id="treMST" style="width:100%; height:470;overflow:auto;" onclicknode="treeItemOnclick()" dragmode=false>
						    </gw:tree>		
				    </td>	
			    </tr>
		      </table>
	    </td>	
	    <td width="80%">
						    <!-- Table2 contain detail grid -->
						    <table id="RightBottomTB"  width="100%" height="100%"   >
    							
    								
								     <!-- Detail Grid Control here --> 
    								
										    <!-- Grid Form --> 
        						
									    <tr>
											    <td align="right" style="width:13%">Upper &nbsp;</td>
											    <td  style="width:87%" colspan="7">
											       
											                    <gw:textbox id="txtIDUpper"  styles='width:30%' readonly = "true"   />
											                    <gw:textbox id="txtUpper"    styles='width:70%' readonly = "true" />
            								   </td>
									    </tr>
									    <tr>
											    <td align="right" style="width:13%">ID &nbsp;</td>
											    
											                <td width="87%" colspan="7">
											                     <gw:textbox id="txtID"  styles='width:30%' csstype="mandatory" />
											                     <gw:textbox id="txtIDr"  styles='width:70%' csstype="mandatory" />
        												    </td>
											            
    											
									    </tr>
									    <tr >
									        
									        <td align="right" style="width:13%"><a title="Click here to select Control1" onclick="OnPopUp(1)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 1</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl1" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:15%">Data Type</td>
									        <td style="width:27%"><gw:list id="lstData1" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS1"   value="N" defaultvalue="Y|N" /></td>
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control2" onclick="OnPopUp(2)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 2</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl2" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData2" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS2"   value="N" defaultvalue="Y|N" /></td>
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control3" onclick="OnPopUp(3)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 3</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl3" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData3" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS3"   value="N" defaultvalue="Y|N" /></td>
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control4" onclick="OnPopUp(4)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 4</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl4" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData4" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS4"   value="N" defaultvalue="Y|N" /></td>
								       </tr>
									     <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control5" onclick="OnPopUp(5)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 5</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl5" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData5" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS5"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									         <td align="right" style="width:13%"><a title="Click here to select Control6" onclick="OnPopUp(6)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 6</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl6" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData6" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS6"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control7" onclick="OnPopUp(7)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 7</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl7" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData7" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS7"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
    									 <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control8" onclick="OnPopUp(8)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 8</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl8" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData8" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS8"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control9" onclick="OnPopUp(9)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 9</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl9" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData9" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS9"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control10" onclick="OnPopUp(10)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 10</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl10" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData10" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS10"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control11" onclick="OnPopUp(11)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 11</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl11" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData11" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS11"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									       <td align="right" style="width:13%"><a title="Click here to select Control12" onclick="OnPopUp(12)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 12</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl12" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData12" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS12"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control13" onclick="OnPopUp(13)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 13</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl13" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData13" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS13"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control14" onclick="OnPopUp(14)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 14</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl14" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData14" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS14"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control15" onclick="OnPopUp(15)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 15</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl15" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData15" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS15"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control16" onclick="OnPopUp(16)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 16</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl16" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData16" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS16"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control17" onclick="OnPopUp(17)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 17</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl17" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData17" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS17"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control18" onclick="OnPopUp(18)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 18</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl18" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData18" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS18"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control19" onclick="OnPopUp(19)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 19</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl19" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData19" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS19"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:13%"><a title="Click here to select Control20" onclick="OnPopUp(20)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Control 20</b></a></td>
									        <td style="width:33%"><gw:list id="lstCtrl20" onchange="CtrlChange()" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData20" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS20"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
						    </table>
						    <!-- End of Table2 -->		
		    </td>
	    </tr>	
    </table>
    
         <gw:textbox id="txttac_ctrlgrp_pk" styles='width:100%' style="display:none" />
         <gw:textbox id="txtP_PK" styles='width:100%' style="display:none" />
         
     
         <gw:textbox id="txttac_ctrlgrp_parent_pk" 			text="0"    style="Display:none" /> 
        
         <gw:textbox id="txtControlID"  text=""  styles='display:none'  />
         <gw:textbox id="txtControlTemp"  text=""  styles='display:none'  />
       
        
        
    </body>
    
   
    </html>
