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
    //OnSearch();
    datTCode_MST.Call("SELECT");
}
function BindingDataList()
{
    System.Translate(document);
    var ls_Company   = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_Control = "<%=ESysLib.SetListDataSQL("select pk , ITEM_NM from TAC_ABITEM where del_if = 0") %>" + "||";
    var ls_DataType = "<%=ESysLib.SetListDataSQL("SELECT B.code, B.CODE_NM from TAC_COMMCODE_MASTER a, TAC_COMMCODE_DETAIL b where B.TAC_COMMCODE_MASTER_PK = A.PK AND id = 'EACBK025' ") %>";
    
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
	      
	     
	       
	    }
    
    
}
function OnSearch()
{
   
        datTCode_MST.Call("SELECT");
    
	
} 
function OnSave()
{   
   datCode_Ctrl_Grp.Call();
   //Update = 'T';
   //datCode_Ctrl_Grp.StatusUpdate();
  
}
function OnDataReceive(obj)
{
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
		    <td width="25%">
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
		    <td width="75%">
					    <!-- Table2 contain detail buttons and text box -->
					    
					    <table id="RightTopTB" style="width:100%" >
						    <tr>
						        <td align="right" style="width:14%">Company</td>
    							<td style="width:51%"><gw:list id="lstCompany" styles="width:100%;" /></td>
    							
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
	    <td width="25%" valign="top">		
		      <table   cellspacing="0" cellpadding="0"  width="100%" height="470">		 
			    <tr  >
				    <td height="100%"  >
					    <!-- Master Grid Control here. Remember add this function oncellclick="RowClick()"--> 
						    <gw:tree  id="treMST" style="width:100%; height:470;overflow:auto;" onclicknode="treeItemOnclick()" dragmode=false>
						    </gw:tree>		
				    </td>	
			    </tr>
		      </table>
	    </td>	
	    <td width="75%">
						    <!-- Table2 contain detail grid -->
						    <table id="RightBottomTB" width="100%" height="100%"  align="top" >
    							
    								
								     <!-- Detail Grid Control here --> 
    								
										    <!-- Grid Form --> 
        						
									    <tr>
											    <td align="right" style="width:10%">Upper &nbsp;</td>
											    <td  style="width:15%" colspan="7">
											        <table style="width:100%">
											            <tr>
											                <td width="75%" align="right">
											                    <gw:textbox id="txtIDUpper"  styles='width:30%' readonly = "true"   />
											                    <gw:textbox id="txtUpper"    styles='width:70%' readonly = "true" />
            																
    												        </td>			 
										               </tr>			
        										
									               </table>
											    </td>
									    </tr>
									    <tr>
											    <td align="right" style="width:10%">ID &nbsp;</td>
											    <td style="width:15%" colspan="7">
											        <table style="width:100%">
											            <tr>
											                <td width="75%">
											                     <gw:textbox id="txtID"  styles='width:30%' csstype="mandatory" />
											                     <gw:textbox id="txtIDr"  styles='width:70%' csstype="mandatory" />
        												    </td>
											            </tr>
											        </table>
											    </td>
    											
									    </tr>
									    <tr>
									        
									        <td align="right" style="width:13%">Control 1</td>
									        <td style="width:33%"><gw:list id="lstCtrl1" styles="width:100%;" /></td>
									        <td style="width:2%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData1" styles="width:100%;" /></td>
									        <td style="width:5%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS1"   value="N" defaultvalue="Y|N" /></td>
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 2</td>
									        <td style="width:33%"><gw:list id="lstCtrl2" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData2" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS2"   value="N" defaultvalue="Y|N" /></td>
									    </tr>
									    <tr>
									         <td align="right" style="width:10%">Control 3</td>
									        <td style="width:33%"><gw:list id="lstCtrl3" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData3" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS3"   value="N" defaultvalue="Y|N" /></td>
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 4</td>
									        <td style="width:33%"><gw:list id="lstCtrl4" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData4" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS4"   value="N" defaultvalue="Y|N" /></td>
								       </tr>
									     <tr>
									       <td align="right" style="width:10%">Control 5</td>
									        <td style="width:33%"><gw:list id="lstCtrl5" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData5" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS5"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 6</td>
									        <td style="width:33%"><gw:list id="lstCtrl6" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData6" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS6"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:10%">Control 7</td>
									        <td style="width:33%"><gw:list id="lstCtrl7" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData7" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS7"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
    									 <tr>
									        <td align="right" style="width:10%">Control 8</td>
									        <td style="width:33%"><gw:list id="lstCtrl8" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData8" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS8"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:10%">Control 9</td>
									        <td style="width:33%"><gw:list id="lstCtrl9" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData9" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS9"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:10%">Control 10</td>
									        <td  style="width:33%"><gw:list id="lstCtrl10" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData10" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS10"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									     <tr>
									        <td align="right" style="width:10%">Control 11</td>
									        <td style="width:33%"><gw:list id="lstCtrl11" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData11" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS11"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 12</td>
									        <td style="width:33%"><gw:list id="lstCtrl12" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData12" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS12"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 13</td>
									        <td style="width:33%"><gw:list id="lstCtrl13" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData13" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS13"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 14</td>
									        <td style="width:33%"><gw:list id="lstCtrl14" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData14" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS14"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 15</td>
									        <td style="width:33%"><gw:list id="lstCtrl15" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData15" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS15"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 16</td>
									        <td style="width:33%"><gw:list id="lstCtrl16" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData16" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS16"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 17</td>
									        <td style="width:33%"><gw:list id="lstCtrl17" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData17" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS17"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 18</td>
									        <td style="width:33%"><gw:list id="lstCtrl18" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData18" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS18"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 19</td>
									        <td style="width:33%"><gw:list id="lstCtrl19" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData19" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
									        <td >Balance</td>
									        <td style="width:5%"><gw:checkbox id="chkSYS19"   value="N" defaultvalue="Y|N" /></td>
								
									    </tr>
									    <tr>
									        <td align="right" style="width:10%">Control 20</td>
									        <td style="width:33%"><gw:list id="lstCtrl20" styles="width:100%;" /></td>
									        <td style="width:4%"></td>
									        <td align="right" style="width:10%">Data Type</td>
									        <td style="width:32%"><gw:list id="lstData20" styles="width:100%;" /></td>
									        <td style="width:1%"></td>
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
        
        
       
        
        
    </body>
    
   
    </html>
