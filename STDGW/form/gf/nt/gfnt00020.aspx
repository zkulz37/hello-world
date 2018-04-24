<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>genuwin</title>
</head>

<%ESysLib.SetUser("acnt")%>
<script type="text/javascript" language="javascript">
function BodyInit()
{
    BindingDataList();
   dat_griddetail.Call("SELECT");
}
function BindingDataList()
{
    var ls_Company   = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    
    lstCompany.SetDataText(ls_Company);
    
    <%=ESysLib.SetGridColumnComboFormat("GridDetail",6,"SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>;
}

function OnSearch(index)
{
    switch(index)
    {
        case 0: // Show data on searching grid
            DSO_Code_MST.Call("SELECT");
        break;
        
    }
    
}
function OnDataReceive(obj)
{
  
    
    switch(obj.id)
    {
        case "dat_griddetail":
        break;
        case "dso_pro_gfnt00020_dup":
            OnCheck_Dup();
        break;
    }
   
}
function OnAddnew()
{
    GridDetail.AddRow();
}
function OnSave()
{
    if(CheckData())
    {
        dat_griddetail.Call();
     }
}
function OnDelete()
{
     GridDetail.DeleteRow();
}
function CheckDuplicate()
{  
    var gr ;
    if(GridDetail.rows > 2)
    {  
        gr = GridDetail.GetGridData(GridDetail.rows -1, 1);    
       for(var i = 1; i < GridDetail.rows - 1; i++)
        {
            if(GridDetail.GetGridData(i, 1) == gr)
            {
                alert('Code is already. Please check again!!!'+ '\n' +'    Code này đã tồn tại. Yêu cầu kiểm tra lại!!!');             
                return false ;
               
            }
        }
    }    
    return true;   
}
function OnCheck_Dup()
{
    if (Number(txt_dupPK.text) == 0)
    {
       
        dat_griddetail.Call();
    }         
    else
    {
        alert('Code  is already. Please check again!!!'+ '\n' +'    Code này đã tồn tại. Yêu cầu kiểm tra lại!!!');
        return;
    }
}
function CheckData()
{
    for(var i=1;i<GridDetail.rows;i++)
          {
            if(GridDetail.GetGridData(i,1) == "")
             {
                alert("Please input Code at row "+ i);
                
                return false;
             }
             if(GridDetail.GetGridData(i,2) == "")
             {
                alert("Please input Name at row "+i);
                return false;
             }
             else if(GridDetail.GetGridData(i,3) == "")
             {
                alert("Please input Local Name  at row "+i);
                return false;
             }
             else if(GridDetail.GetGridData(i,4) == "ALL")
             {
                alert("Please input Foreign Name at row "+i);
                return false;
             }
             else if(GridDetail.GetGridData(i,5) == "ALL")
             {
                alert("Please input Company at row "+i);
                return false;
             }
          }
          return true;
}
</script>
<body>
 <gw:data id="DSO_Code_MST" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfnt00020_code_master " > 
            <input  >
                <input bind="txtGroup"/>
                <input bind="lstCompany" />
                
            </input>
            <output bind="GridDetail" /> 
        </dso> 
    </xml> 
</gw:data>

<!--------------------------------------------------------------------------------------->
<gw:data id="dat_griddetail"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6" function="acnt.sp_sel_gfnt00020_grd_detail" procedure="acnt.sp_upd_gfnt00020_grddetail"   > 
            <input bind="GridDetail">                    
                <input bind="txttac_stgrp_pk" /> 
                
            </input> 
            <output bind="GridDetail"></output>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<!-- gw:data id="dso_pro_gfnt00020_dup"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="process" procedure="ACNT.SP_PRO_gfnt00020_DUPLICATE" > 
               
           
                <output>  
                     <output  bind="txt_dupPK"/>
               </output> 
            </dso> 
        </xml>
    </gw:data --->
<!--------------------------------------------------------------------------------------->
<table border="1" width="100%">
    <tr>
	   
	   <td>
	    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table4">
		    <tr>
			    <td colspan="2">
				
				    <fieldset style="width: 100%; height: 100%; padding: 2">
					
				    <table border="0" width="100%" cellpadding="0" cellspacing="0"  id="table2">
					    <tr>
						    <td align="right" style="width:14%">Company &nbsp;</td>
							<td style="width:41%"><gw:list id="lstCompany" styles="width:100%;" /></td>
							<td width="10%" align="right">Group &nbsp;</td>
                            <td width="25%"><gw:textbox id="txtGroup" onenterkey="OnSearch()" styles="width:100%;" /></td>
					        <td width="1%" align="right"><gw:imgbtn id="btnreset3" img="reset" alt="Reset" onclick="txtGroup.text='';" /></td>  
					        <td width="1%" align="right"><gw:imgbtn id="btnSearch" img="Search" alt="Search" onclick="OnSearch(0)" /></td>    
						    
						    <td ><gw:imgBtn id="ibtnReset" img="new" alt="new"	onclick="OnAddnew()"  	/></td>
						    
						    <td ><gw:imgBtn id="ibtnDelete" img="delete" alt="delete" 	onclick="OnDelete()" 	 /></td>  
						    <td ><gw:imgBtn id="ibtnUpdate" img="save" alt="save" 	onclick="OnSave()" 	 /></td>
						    		
					    </tr>
						
				    </table>
				    </fieldset>
			    </td>
		    </tr>
			
		    <tr>
			    <td colspan="2">
				
			   
				
			        <table border="0" width="100%"  cellpadding="0" cellspacing="0" id="table3">
		                
	                   <tr>
	                        
		                    <td colspan="5">
		                         <gw:grid   
		                                id="GridDetail"  
		                                header="_PK|Code|Name|Local Name|Foreign Name|IFRS_YN|Company"   
		                                format="0|0|0|0|0|3|0"  
		                                aligns="0|0|0|0|0|0|0"  
		                                defaults="||||||"  
		                                editcol="1|1|1|1|1|1|1"  
		                                widths ="0|1000|2500|2500|2500|800|1500"  
		                                styles="width:100%; height:450"   
		                                sorting="T"   
			                            onafteredit="CheckDuplicate()" 
			                            
			                            
		                         /> 
		                    </td>
	                   </tr>
                    </table>

		       
		        </td>
		    </tr>
	    </table>
	    </td>
	    </tr>
	    </table>
	   
        <gw:textbox id="txt_dupPK"      style="display:none"/>
        <gw:textbox id="txttac_stgrp_pk"  style="Display:none" /> 
</body>
</html>
