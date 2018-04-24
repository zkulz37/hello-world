<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vina Genuwin</title>
</head>
<%ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">
 var g_select = false;
 var flag = 0;
 
 var Insert      = 'F';
var Update      = 'F';
var Delete    = 'F';
function BodyInit()
{

    BindingDataList();
   OnSearch(0);
   ibtnGenerate.SetEnable(false);
  
}
//----------------------------------------------------------------------------------
function BindingDataList()
{
    var ls_Company   = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_DataType    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0190','','') FROM DUAL")%>";
    var ls_InputType     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0050','','') FROM DUAL")%>";
    var ls_Group = "<%=ESysLib.SetListDataSQL("select pk, grp_cd||' - '|| grp_nm from tac_stgrp where del_if = 0 order by grp_cd ") %>";
    var ls_Group_I = "<%=ESysLib.SetListDataSQL("select pk, grp_cd||' - '|| grp_nm from tac_stgrp where del_if = 0 order by grp_cd ") %>|ALL|[SELECT ALL]";
    var ls_Table = "<%=ESysLib.SetListDataSQL("SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACBK026' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM ") %>";
    
    lstCompany.SetDataText(ls_Company);
    lstCompany_I.SetDataText(ls_Company);
    lstDataType.SetDataText(ls_DataType);
    lstInputType.SetDataText(ls_InputType);
    lstGroup.SetDataText(ls_Group);
    lstGroup_I.SetDataText(ls_Group_I);
    lstGroup_I.value='ALL';
    lstTable.SetDataText(ls_Table);
    //Group
    <%=ESysLib.SetGridColumnComboFormat( "Grid_Inquiry" , 0 , "select pk, grp_cd||' - '|| grp_nm from tac_stgrp where del_if = 0 order by grp_cd") %>;  
    //Input Type
    <%=ESysLib.SetGridColumnComboFormat( "Grid_Inquiry" , 5 , "SELECT E.CODE , E.CODE_NM FROM TCO_ABCODE E , TCO_ABCODEGRP F WHERE E.DEL_IF=0 AND F.DEL_IF =0 AND E.TCO_ABCODEGRP_PK = F.PK AND F.ID='ACAB0050' ORDER BY E.CODE_NM") %>;       
    //Data Type
    <%=ESysLib.SetGridColumnComboFormat( "Grid_Inquiry" , 7 , "SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACBK026' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM") %>; 
    //Table
    <%=ESysLib.SetGridColumnComboFormat( "Grid_Inquiry" , 6 , "SELECT E.CODE , E.CODE_NM FROM TCO_ABCODE E , TCO_ABCODEGRP F WHERE E.DEL_IF=0 AND F.DEL_IF =0 AND E.TCO_ABCODEGRP_PK = F.PK AND F.ID='ACAB0190' ORDER BY E.CODE_NM") %>;       
}
//----------------------------------------------------------------------------------
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//-----------------------------------------------------------------------------------
function InTypeChange()
{
    var Idtable = lstTable.GetText();
     var strSQL = "Select * from " + Idtable ;
    if(lstInputType.GetData() == "C")
    {
        txtSQLtext.SetData("");
        txtSQLtext.SetReadOnly(false);
        lstTable.SetEnable(true);
    }
    
   else if(lstInputType.GetData() == "T")
   {
	   if(Trim(txtSQLtext.GetData())=="" )
	   {
		 txtSQLtext.SetReadOnly(true);
		 txtSQLtext.GetControl().focus();
		 strSQL += lstInputType.GetText();
		 txtSQLtext.SetDataText(strSQL);
		 lstTable.SetEnable(true);
		 
	   }
	}
	else if(lstInputType.GetData() == "M")
	{
	   
	    
	        txtSQLtext.SetData("");
            txtSQLtext.SetReadOnly(true);
            lstTable.SetEnable(false);
       
	}
	
	
   /* if (!g_select)
    {
        if (txt_PK.GetData() == "")
        {
            if (dso_upd_Control.GetStatus() != 20)
            {
                dso_upd_Control.StatusInsert();
            }
        }
        else
        {
            
        }
    }*/
}
//---------------------------------------------------------------------------------
/*function CheckDuplicate()
{       
   for(var i = 1; i < GridSearch.rows; i++)
    {
        if(GridSearch.GetGridData(i, 2) == txtID.text)
        {
            alert('ID ('+ txtID.GetData()+ ') is already. Please check again!!!'+ '\n' +'    ID này đã tồn tại. Yêu cầu kiểm tra lại!!!');
             txtID.GetControl().focus();
            return false ;
           
        }
    }
    return true;
   
}*/
//----------------------------------------------------------------------------------
function TableChange()
{
    var table = "Select * from ";
    if(lstInputType.GetData() == "C")
    {
        txtSQLtext.SetData("");
        txtSQLtext.SetReadOnly(true);
    }
    else if(lstInputType.GetData() == "T")
    {
    
         txtSQLtext.GetControl().focus();
         table += lstTable.GetText();
	     txtSQLtext.SetDataText(table);
	 }
	
}
//----------------------------------------------------------------------------------
function chkChange()
{
    if(chkID.GetData()=="Y")
    {
        txtID.SetEnable(false);
        txtName.SetEnable(false);
    }
    else if(chkID.GetData()=="N")
    {
        txtID.SetEnable(true);
        txtID.GetControl().focus();
        txtName.SetEnable(true);
   
    }
}
//----------------------------------------------------------------------------------
function OnNew(obj)
{
    switch(obj)
    {
        case 0:
            flag = '1';
            g_select = false;
            dso_upd_Control.StatusInsert();
            chkActive.SetDataText("Y");
            chkChange();
            ibtnGenerate.SetEnable(false);
        break;
        case 1:
            
            Grid_Inquiry.AddRow();
            if(lstGroup_I.value!='ALL')
            {
                Grid_Inquiry.SetGridText(Grid_Inquiry.rows-1, 0, lstGroup_I.value);
            }
            Grid_Inquiry.SetGridText(Grid_Inquiry.rows-1, 12, lstCompany_I.value);
            Grid_Inquiry.SetGridText(Grid_Inquiry.rows-1, 5, 'C');
            Grid_Inquiry.SetGridText(Grid_Inquiry.rows-1, 6, 'C');
            Grid_Inquiry.SetGridText(Grid_Inquiry.rows-1, 7, '01');
            Grid_Inquiry.SetGridText(Grid_Inquiry.rows-1, 10, '-1');
        break;
    }
        

}
//----------------------------------------------------------------------------------
var Status='';
function OnSave(obj)
{
    switch(obj)
    {
        case 0:
            g_select = false;
            if (dso_upd_Control.GetStatus() == 20)
            {
                if(CheckData())
                {
                        ibtnGenerate.SetEnable(true);
                        Status = 'Save';
                        dso_pro_subcode_dup.Call();
                 }
             }
            else if(dso_upd_Control.GetStatus() == 10)
            {
                flag='1';
                Status = 'Save';
                dso_pro_subcode_dup.Call();
                //dso_upd_Control.Call();
            }
        break;
        case 1:
            dso_update_grid.Call();
        break;
    }
}
//-------------------------------------------------------------------------------
function  OnPopUp(index)
 {
            var index;
            var path = System.RootURL + '/form/gf/nt/gfnt00040_popup.aspx';
		    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
		         strgroupreturn = object[1];
                indexGroup = index;
                 
		        if (object[0] == 0)
               
                {    
                       
                    datGetNewGroup.Call();
                 
                }            
                else
                {
                   switch(index)
                   {
                        case 1:
                            lstGroup.value = strgroupreturn; 
                              
                        break;
                   }
                }
             }
}
//----------------------------------------------------------------------------------
function OnDataReceive(obj)
{
        var strdata = txtGroupTemp.text;

      if(obj.id == 'dso_upd_Control')
        {
               
               chkActive.SetDataText("Y");
               chkChange();
               if(Status=='Save'||Status=='Delete')
               {
                    DSO_Code_MST.Call("SELECT");   
                }
        }
       else if (obj.id == 'DSO_Code_MST')
          {  
            InTypeChange();
          } 
        

        else if(obj.id == 'dso_pro_subcode_dup')
            {
           
                 OnCheck_Dup();
            
            }
        else if(obj.id == 'dso_upd_approve')
        {
            
            OnSearch(0);
            
          txtID.text = txtReturn.text ;
          txtName.text = txtReturn2.text ;
        }
     
     
        else if(obj.id == 'datGetNewGroup')
        {
            switch(indexGroup)
            {
                case 1:
                     lstGroup.SetDataText(strdata);
                     lstGroup.value = strgroupreturn;
                 break;
            }
        }
       
             
       
    
   
}
//----------------------------------------------------------------------------------
function OnCheck_Dup()
{
    if (Number(txt_dupPK.text) == 0)
    {
        txtID.SetEnable(false);
        dso_upd_Control.Call();
       
    } 
    
      
    else
    {
        alert('ID ('+ txtID.GetData()+ ') is already. Please check again!!!'+ '\n' +'    ID này đã tồn tại. Yêu cầu kiểm tra lại!!!');
        txtID.GetControl().focus();
        return ;
    }
}
//---------------------------------------------------------------------------------
function OnSearch(index) 
{
     switch(index)
    {
        case 0: // Show data on searching grid
            DSO_Code_MST.Call("SELECT");
        break;
        case 1: // Show data on control when click on searching grid
            txt_PK.SetDataText(GridSearch.GetGridData(GridSearch.row,0));
            flag='search';
            Status='Search';
            dso_upd_Control.Call('SELECT');
        break;    
    }
    

  
}
//----------------------------------------------------------------------------------
function OnDelete(obj)
{
    switch(obj)
    {
        case 0:
            if (txt_PK.GetData() == "")
            {
	            alert('Please select ID to delete!!!'+'\n'+'Yêu cầu lựa chọn ID cần xóa!!!');
	            return;
	        }
            else
            {
	            if (confirm('  Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa ID này?'))
	            {
	                Delete = 'T';
                    Status = 'Delete';
	                dso_upd_Control.StatusDelete();
		            dso_upd_Control.Call();
		        }
            }
        break;
        case 1:
            if (confirm('  Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa ID này?'))
	            {
	                Grid_Inquiry.DeleteRow();
		            dso_update_grid.Call();
		        }
        break;
    }
}
//------------------------------------------------------------------------------------
function OnSearch_Grid()
{
    dso_update_grid.Call('SELECT');
}
function CheckData()
{
  

    if(chkID.GetData()=='N' && txtID.GetData()=='')
    {
        alert('Please input ID!'+'\n'+'Vui lòng nhập ID');
        txtID.GetControl().focus();
        return false;
    }
   else if(chkID.GetData()=='N' && txtName.GetData() == '')
   {
        alert('Please input Name!'+'\n'+'Vui lòng nhập Name!');
        txtName.GetControl().focus();
        return false;
   }
    
   return true;
}
//-------------------------------------------------------------------------------------
function OnAppove()
{
    
    if(chkID.GetData()=='N')
            {
                alert('Please checked auto!!!');
            }
        
    //        if(CheckData())
    //        {
            
            else if(chkID.GetData()=='Y')
            { 
//            if(CheckData())
//            {
                if(confirm('Do you want to generate the selected ID ?'))
                {
                     dso_upd_approve.Call();
                }
//             }   
            }    
        
     
}
//--------------------------------------------------------------------------------------
</script>
<body>
<gw:data id="DSO_Code_MST" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfnt00040_subcode_grid " > 
            <input>
                <input bind="txtGroup"/>
                <input bind="lstCompany" />
                <input  bind="chkActive"/>
                
            </input>
            <output bind="GridSearch" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------------------->
 <gw:data id="dso_upd_Control" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="acnt.sp_sel_gfnt00040_Control" procedure = "acnt.sp_udp_gfnt00040_control"> 
            <inout> 
                <inout bind="txt_PK"/>
                <inout bind="lstGroup" />
                <inout bind="txtID" />
                <inout bind="txtName" />
                <inout bind="txtLocalName" />
                
                <inout bind="txtFname" />
                <inout bind="lstInputType" />
                <inout bind="lstDataType" />
                <inout bind="txtSQLtext" />
                <inout bind="txtDescription" />
                
                <inout bind="lstTable" />
                <inout bind="lstTable_pk" />
                <inout bind="lstCompany" />
                <inout bind="chkID" />
                <inout bind="chkActive" />
                
                
            </inout>
            </dso> 
        </xml> 
    </gw:data> 
    
<!------------------------------------------------------------------------------------->
 <gw:data id="dso_upd_approve" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="process" function="acnt.sp_select_gfnt00040_Approve" procedure="acnt.sp_upd_gfnt00040_approve" > 
            <input> 
                
              
                <input bind="lstGroup" />
                <input bind="txtLocalName" />
                <input bind="txtFname" />
                <input bind="lstInputType" />
                <input bind="lstDataType" />
                
                <input bind="txtSQLtext" />
                <input bind="txtDescription" />
                <input bind="txt_PK" />
                <input bind="chkID" />
                <input bind="chkActive" />
                
                <input bind="lstTable" />
             </input>  
             <output>
                <output bind="txtReturn" />
               <output bind="txtReturn2" />
             </output>
        </dso> 
    </xml> 
  </gw:data>
<!------------------------------------------------------------------------------------->
<gw:data id="dso_pro_subcode_dup"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="process" procedure="ACNT.SP_PRO_SUB_CD_DUPLICATE" > 
                <input> 
                     <input  bind="txtID" />
                     <input  bind="lstGroup" />
                     <input  bind="txt_PK" />                     
                </input>  
                <output>  
                     <output  bind="txt_dupPK"/>
               </output> 
            </dso> 
        </xml>
    </gw:data>
<!------------------------------------------------------------------------------------>
<gw:data id="datGetNewGroup" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="acnt.sp_sel_gfnt00040_new_group" > 
                <input> 
                    <input bind="lstGroup" /> 
                </input>
	           <output>
	                <output bind="txtGroupTemp" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
<!------------------------------------------------------------------------------------->
<gw:data id="dso_update_grid"  onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="ACNT.sp_sel_gfnt00040_grid" procedure="ACNT.SP_UPD_gfnt00040_grid">
            <input bind="Grid_Inquiry" >                            
                <input bind="lstCompany_I" />
                <input bind="lstGroup_I" />
                <input bind="chkActive_I" />
            </input>
            <output bind="Grid_Inquiry" />
        </dso>                    
    </xml>
</gw:data>
   <table border="0" style="width:100%;height:100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <gw:Tab>
                    <table border="1" bordercolor="#00CCFF" style="border-collapse: collapse" name="Sub Code Entry" style="width:100%;height:100%" cellpadding="0" cellspacing="0">
                        <tr>
	        <td id="left" width="35%" valign="top">
                  <table border="0" style="width:100%;height:100%" cellpadding="0" cellspacing="0"  id="table5">
	                <tr style="height:2%">
	                    <td width="100%">
	                        <fieldset style="width: 100%; height: 100%; padding:0">
	                             <table border="0" width="100%" cellpadding="0" cellspacing="0"  id="table1">
				                    <tr>
					                    <td width="30%" align="right">Sub code &nbsp;</td>
                                        <td width="65%" ><gw:textbox id="txtGroup" onenterkey="OnSearch()" styles="width:100%;" /></td>
					                    <td width="5%" align="left"><gw:imgbtn id="btnreset3" img="reset" alt="Reset" onclick="txtGroup.text='';" /></td>  
					                    <td width=""><gw:imgbtn id="btnSearch" img="Search" alt="Search" onclick="OnSearch(0)" /></td>                                     
				                    </tr>
				                  </table>  
	                         </fieldset>
	                    </td>
	                </tr>
				    <tr style="height:98%">
					    <td width="100%"  colspan="4">
					        <gw:grid   
	                            id="GridSearch"  
	                            header="_pk|No|ID|Group Name|Name"   
	                            format="0|0|0|0|0"  
	                            aligns="0|1|0|0|0"  
	                            defaults="||||"  
	                            editcol="1|1|1|1|1"  
	                            widths="0|600|1500|1500|1000"  
	                            styles="width:100%; height:100%"   
	                            sorting="F"   
	                            oncellclick="OnSearch(1)"
			                   
    	                             /> 
					    </td>
                    </tr>
			    </table>	
	        </td>
	        <td align="center" id="right" style="width:65%" valign="top">
	    <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%">
		    <tr style="height:2%">
			    <td >
				    <fieldset style="width: 100%; height: 100%; padding: 0">
				    <table  border="0" width="100%" cellpadding="0" cellspacing="0"  >
					    <tr >
						    <td align="right" style="width:20%">Company&nbsp;</td>
							<td style="width:58%"><gw:list id="lstCompany" styles="width:100%;" /></td>
							<td align="right" style="width:15%">Active</td>
							<td style="width:"><gw:checkbox id="chkActive"   value="Y" defaultvalue="Y|N"  /></td>
						    <td width="5%"></td>
						    <td ><gw:imgBtn id="ibtnReset" img="new" alt="new"	onclick="OnNew(0)"  	/></td>
						    <td ><gw:imgBtn id="ibtnDelete" img="delete" alt="delete" 	onclick="OnDelete(0)" 	 /></td>  
						    <td ><gw:imgBtn id="ibtnUpdate" img="save" alt="save" 	onclick="OnSave(0)" 	 /></td>
                            <td width="2%"></td>
						    <td ><gw:icon id="ibtnGenerate" img="in" alt="Generate" text="Generate"	onclick="OnAppove()" /></td>		
					    </tr>
						
				    </table>
				    </fieldset>
			    </td>
		    </tr>
			
		    <tr align="center" style="height:98%">
			    <td align="center" valign="top">
			        <table align="center" border="0" width="100%"  cellpadding="0" cellspacing="0" id="table3">
		                
	                    <tr align="center">
								
								<td align="right" style="width:10%"><a title="Click here to select Control1" onclick="OnPopUp(1)" href="#tips" 
									        style="text-decoration: none; color=#0000ff"><b>Group</b></a></td>
								<td  style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:list id="lstGroup" styles='width:100%'> </gw:list ></td>
										</tr>
									</table>
								 </td>
								
						</tr>
	                    <tr>
								<td style="width:10%" align="right">ID</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:textbox id="txtID" styles="width:100%;"   csstype = 'mandatory' /></td>
											<td style="width:100%"><gw:checkbox id="chkID"   value="N" defaultvalue="Y|N" onclick="chkChange()" /></td>
											<td>Auto</td>
										</tr>
									</table>
								 </td>
						</tr>
						<tr>
								<td style="width:10%" align="right">Name</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:textbox id="txtName" styles="width:100%;" csstype = 'mandatory' /></td>
										</tr>
									</table>
								 </td>
						</tr>
	                    <tr>
								<td style="width:10%" align="right">Local Name</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:textbox id="txtLocalName" styles="width:100%;"  /></td>
										</tr>
									</table>
								 </td>
						</tr>
	                    <tr>
								<td style="width:10%" align="right">Fname</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:textbox id="txtFname" styles="width:100%;" /></td>
										</tr>
									</table>
								 </td>
						</tr>
	                   <tr>
								<td style="width:10%" align="right">Input Type</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:list id="lstInputType"  onchange="InTypeChange()" styles="width:100%;" /></td>
										</tr>
									</table>
								 </td>
						</tr>
                        <tr>
								<td style="width:10%" align="right">Data Type</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:list id="lstDataType" styles="width:100%;" /></td>
										</tr>
									</table>
								 </td>
						</tr>
                       <tr>
								<td style="width:10%" align="right">Table</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:list id="lstTable" onchange="TableChange()" styles="width:100%;" /></td>
										</tr>
									</table>
								 </td>
						</tr>
						<tr>
								<td style="width:10%" align="right" valign="top">SQL text</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:textarea id="txtSQLtext" styles="width:100%;height:180;"></gw:textarea></td>
										</tr>
									</table>
								 </td>
						</tr>
                        <tr>
								<td style="width:10%" align="right">Description</td>
								<td style="width:90%">
									<table width="100%" >
										<tr>
											<td style="width:100%"><gw:textbox id="txtDescription" styles="width:100%;" /></td>
										</tr>
									</table>
								 </td>
						</tr>
						
                    </table>
		      
		        </td>
		    </tr>
	    </table>
	    </td>
	    </tr>
                    </table>
                    <table  name="Sub Code Inquiry" style="width:100%;height:100%" cellpadding="0" cellspacing="0">
                        <tr style="height:2%">
                            <td>
                                <fieldset style="padding:0">
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="right" style="width:10%">Company&nbsp;</td>
							                <td style="width:40%"><gw:list id="lstCompany_I" styles="width:100%;" /></td>
                                            <td align="right" style="width:10%"><a title="Click here to select Group" onclick="OnPopUp(1)" href="#tips" style="text-decoration: none;">Group&nbsp;</a></td>
                                            <td style="width:25%"><gw:list id="lstGroup_I" styles='width:100%'> </gw:list ></td>
                                            <td align="right" style="width:10%">Active</td>
							                <td style="width:"><gw:checkbox id="chkActive_I" value="Y" defaultvalue="Y|N" onchange="OnSearch_Grid()" /></td>
                                            <td width="5%"></td>
                                            <td ><gw:imgBtn id="ibtnReasset" img="search" alt="search"	onclick="OnSearch_Grid()"  	/></td>
                                            <td ><gw:imgBtn id="ibtnResset" img="new" alt="new"	onclick="OnNew(1)"  	/></td>
                                            <td ><gw:imgBtn id="ibtnUpddate" img="save" alt="save" 	onclick="OnSave(1)" 	 /></td>
						                    <td ><gw:imgBtn id="ibtnDdelete" img="delete" alt="delete" 	onclick="OnDelete(1)" 	 /></td>  
						                    
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                        <tr style="height:98%">
                            <td width="100%" >
                            <!--header="0.Group|1.ID|2.Name|3.Local Name|4.Foreign Name|5.Input Type|6.Data Type|7.Table|8.SQL text|9.Description|10.pk|11.company"-->
					        <gw:grid   
	                            id="Grid_Inquiry"  
	                            header="Group|ID|Name|Local Name|Foreign Name|Input Type|Data Type|Table|SQL text|Description|Active Y/N|_pk|_company_pk"   
	                            format="0|0|0|0|0|0|0|0|0|0|3|0|0"  
	                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            defaults="||||||||||||"  
	                           editcol="1|1|1|1|1|1|1|1|1|1|1|1|1"  
	                            widths="3000|1500|2500|2500|2500|2000|2000|2000|3000|3000|1000|0|0"  
	                            styles="width:100%; height:100%"   
	                            sorting="F"   
	                            oncellclick=""
			                   
    	                             /> 
					    </td>
                        </tr>
                    </table>
                </gw:Tab>
            </td>
        </tr>
        
	</table>
	    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;display:none" onclick="OnToggle()" />
        
        
        <gw:textbox id="txt_PK" style="display:none"/> 
        <gw:textbox id="lstTable_pk" style="display:none"/> 
        <gw:textbox id="txt_dupPK"      style="display:none"/> 
        <gw:textbox id="txtReturn"      style="display:none"/> 
        <gw:textbox id="txtReturn2"      style="display:none"/> 
        
    <gw:textbox id="txtGroupTemp"  text=""  styles='display:none'  />
</body>
</html>
