﻿<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Vina Genuwin</title>
</head>
<%ESysLib.SetUser("acnt")%>
<script type="text/javascript" language="javascript">
var AdminYN;
AdminYN ="<%=Session("CODEADMIN_YN")%>";

var v_language = "<%=Session("SESSION_LANG")%>";
var lb_select = false;
var lb_delete = false;
function BodyInit()
{
        System.Translate(document); 
       
        BindingDataList();
       
}

function BindingDataList()
{ 
    var data;
    data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(data);
    //
    data = "<%=ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('ACAB0070','','') FROM DUAL")%>";
    lstGroup.SetDataText(data);
   
}
function OnSearch(index)
{
    switch(index)
    {
        case 0:
            data_gfnt00070_1.Call('SELECT');
        break;
    }
}
//-------------------------------------------------------
function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "data_gfnt00070_1":
          
        break;
     }
 }   
//-------------------------------------------------------
function OnNew()
{
    //GridDetail.AddRow();
    onRowDoubleclk(0);
} 
//-------------------------------------------------------
function onRowDoubleclk(index)
{
    switch(index)
    {
        case 0:
            if (GridDetail.rows < 1) 
            {
             return;
            }
            else
            {
                var fpath = System.RootURL + "/form/60/01/60010120_1.aspx?TAC_ABTRTYPE_pk=" + txtMaster_pk.GetData();
                aValue = System.OpenModal( fpath , 850 , 550 , 'resizable:yes;status:yes');
               
                if(aValue !=null)
                {
                   
                  if (aValue.length >= 1)
                    {
	                  for(var i=0; i<aValue.length ; i++)
                        {
                            var tmp = new Array();
                            
                            tmp = aValue[i];
        	               //alert(tmp[1]);
                           // if (tmp[0] != 0)
                           // {
                                GridDetail.AddRow();
                                // <!--0.Chk|1.User ID|2.Emp ID|3.Employee Name|4.Department|5.tco_bsuser_pk|TAC_ABTRTYPE_pk-->
                                GridDetail.SetGridText(GridDetail.rows - 1, 1, tmp[1]);    //User ID
                                GridDetail.SetGridText(GridDetail.rows - 1, 2, tmp[2]);    //Emp ID
                                GridDetail.SetGridText(GridDetail.rows - 1, 3, tmp[3]);    //mployee Name
                                GridDetail.SetGridText(GridDetail.rows - 1, 5, tmp[5]);  //tco_bsuser_pk
                                GridDetail.SetGridText(GridDetail.rows - 1, 6, txtMaster_pk.text);  // TAC_ABTRTYPE_pk 
                          // }
                       }
                  } 
                }
            }
           break; 
           case 1:
            txtMaster_pk.SetDataText(GridSearch.GetGridData(GridSearch.row,0));
            data_gfnt00070_2.Call('SELECT')
           break;
     }   
    
}
//-------------------------------------------------------
function OnSave()
{
    data_gfnt00070_2.Call();
}
//-------------------------------------------------------
function OnDelete()
{
    var ctrl 	= GridDetail.GetGridControl();
    var rownum 	= Number(ctrl.Row);
    var rownums = Number(ctrl.Rows);
    if ((rownums > 1) && (rownum > 0))
    {
        for(i=1; i<rownums; i++)
        {
	        if (ctrl.isSelected(i) == true)
            {
	            GridDetail.DeleteRow();
	        }
        }
        OnSave(); 
    }
    else
    {
        alert('Please select row for delete!!!'+'\n'+'Bạn hãy chọn 1 dòng để xóa');
    }
}
//-------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------------->
 <gw:data id="data_gfnt00070_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso type="grid" function="ac_SEL_60010120_1" parameter="0,1,2,3"> 
                <input bind="GridSearch" > 
                    <input bind="lstCompany" /> 
                    <input bind="lstGroup" /> 
                    <input bind="txtCode" /> 
                    <input bind="txtName" /> 
                </input> 
                <output bind="GridSearch" /> 
            </dso> 
        </xml> 
 </gw:data> 
 <!----------------------------------------------------------------------------->
   <gw:data id="data_gfnt00070_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,5,6" function="ac_sel_60010120_2" procedure="ac_upd_60010120_1">
                <input bind="GridDetail">                    
                <input bind="txtMaster_pk" /> 
                
            </input> 
            <output bind="GridDetail"></output>
            </dso>
        </xml>
    </gw:data>

        <table border="1" width="100%">
    <tr>
	    <td id="left" width="40%" valign="top">
		    
	            <table border="0" width="100%" cellpadding="0" cellspacing="0"  id="table5">
	                <tr>
	                    <td width="100%">
	                        <fieldset style="width: 100%; height: 100%; padding: 2">
	                             <table border="0" width="100%" cellpadding="0" cellspacing="2"  id="table1">
				                    <tr>
					                    <td  align="right" width="40%">Company&nbsp;</td>
                                        <td width="55%"><gw:list id="lstCompany" styles="width:100%;" /></td>
					                    <td width="5%"  align="right"><gw:imgbtn id="btnSearch" img="Search" alt="Search" onclick="OnSearch(0)" /></td>   
					                          
				                    </tr>
				                    <tr>
				                        <td width="40%" align="right">Transaction group&nbsp;</td>   
					                    <td width="60%" colspan="2"><gw:list id="lstGroup" styles="width:100%;" onchange="OnSearch(0)" /></td>     
				                    </tr>
				                    <tr>
				                         <td width="40%" align="right">Transaction code&nbsp;</td>
					                     <td width="60%" colspan="2"><gw:textbox id="txtCode"  styles="width:100%;" /></td>   
				                    </tr>
				                    <tr>
				                         <td width="40%" align="right">Transaction name&nbsp;</td>
				                         <td width="60%" colspan="2"><gw:textbox id="txtName"  styles="width:100%;" /></td>
				                    </tr>
				                    <tr>
				                        
				                    </tr>
				                  </table>  
	                         </fieldset>
	                    </td>
	                </tr>
					
				    <tr>
					    <td width="100%" >
					        <gw:grid   
	                            id="GridSearch"  
	                            header="_pk|Code|Transaction Name"   
	                            format="0|0|0"  
	                            aligns="0|0|0"  
	                            defaults="||"  
	                            editcol="1|1|1"  
	                            widths="0|1000|2000"  
	                            styles="width:100%; height:435"   
	                            sorting="F"   
	                            oncellclick="onRowDoubleclk(1)"
			                   
    	                       /> 
					    </td>
                    </tr>
			    </table>			
		   
	    </td>
	    <td align="center" id="right" style="width:60%" valign="top">
	    <table  border="0" cellpadding="0" cellspacing="0" width="100%">
		    <tr >
			    <td >
				
				    <fieldset style="width: 100%; height: 100%; padding: 2">
					
				    <table  border="0" width="100%" cellpadding="0" cellspacing="2"  >
					    <!--tr >
						    <td align="right" style="width:30%">User ID/Emp ID&nbsp;</td>
							<td colspan="2" style="width:65%"><gw:textbox id="txtUserID"  styles="width:100%;" /></td>
							<td  style="width:5%"><gw:checkbox id="chkActive"   value="Y" defaultvalue="Y|N"  /></td>
							<td  >Active</td>
					    </tr-->
					    <tr>
					        <!--td align="right" style="width:30%">Employee Name&nbsp;</td>
							<td colspan="2" style="width:65%"><gw:textbox id="txtEmployeeName"  styles="width:100%;" /></td-->
							<td width="95%"></td>
							<td width="5%" align=right>
							    <table >
							        <tr>
							            <td ><gw:imgBtn id="ibtnReset" img="new" alt="new"	onclick="OnNew()"  	/></td>
						                <td ><gw:imgBtn id="ibtnUpdate" img="save" alt="save" 	onclick="OnSave()" 	 /></td>
						                <td ><gw:imgBtn id="ibtnDelete" img="delete" alt="delete" 	onclick="OnDelete()" 	 /></td>  
							        </tr>
							    </table>
							</td>
							
					    </tr>
						
				    </table>
				    </fieldset>
			    </td>
		    </tr>
			       
		    <tr>
		        <!--0_pk|1.User ID|2.Emp ID|3.Emp Name|4.Company|5_tco_bsuser_pk|6_TAC_ABTRTYPE_pk-->
	             <td width="100%"  >
				        <gw:grid   
                            id="GridDetail"  
                            header="_pk|User ID|Emp ID|Emp Name|_Company|_tco_bsuser_pk|_TAC_ABTRTYPE_pk"   
                            format="0|0|0|0|0|0|0"  
                            aligns="0|0|0|0|0|0|0"  
                            defaults="||||||"  
                            editcol="1|1|1|1|1|0|0"  
                            widths="0|1000|1500|2000|1500|0|0"  
                            styles="width:100%; height:435"   
                            sorting="F"   
                            oncelldblclick  ="onRowDoubleclk(0)" 
		                   
	                             /> 
				    </td>
		    </tr>
	    </table>
	    </td>
	    </tr>
	    </table>
	     <gw:textbox  id="txtMaster_pk" styles='display:none'/>
</body>    
</html>
