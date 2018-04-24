<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Bussiness Partner Entry</title>
</head>
<%  ESysLib.SetUser("comm")%>
<%  ESysLib.SetUser("esys")%>

<script>
 var status_control;
 //---------------------------------------------------------
 function BodyInit()
 { 
   
    
     System.Translate(document);
     BindingDataList();
     Merge_grid();
     Grid1.GetGridControl().WordWrap = true;
     Grid2.GetGridControl().WordWrap = true;
     Grid3.GetGridControl().WordWrap = true;
     Grid4.GetGridControl().WordWrap = true;
 }
 //---------------------------------------------------------
 function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
			    txtProject_Pk.text = object[0];
                txtProject_Cd.text = object[1];
                txtProject_Nm.text = object[2]; 
			    //OnSearch();
		    }
	    break;
        case 'Work_Breakdown':
            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown_1.aspx';
            var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
			    if (obj[2] != 0)
			    {
				    lstWork_Breakdown.SetDataText(obj[2]);
			    }   
            }
        break;
                   
        case 'OutsideOrderWork':
             var path = System.RootURL + "/form/kp/bm/kpbm00010.aspx";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.orderingconttypename  FROM ec111.tecps_orderingconttype a WHERE a.del_if = 0 order by a.pk desc")%>"; 
             lstOrdWork.SetDataText(data);
        break; 
    }
    
}
//---------------------------------------------------------
function OnPopUpList()
{
    var path = System.RootURL + '/form/kp/bm/kpbm00040_popup_list.aspx';
    var object = System.OpenModal( path ,200 , 400 , 'resizable:yes;status:yes');   
}
 //---------------------------------------------------------
 
function Merge_grid()
{
        if (Grid2.rows < 2)
		{
			
			Grid2.AddRow();
		}
		
	    var fg=Grid2.GetGridControl();
		    fg.FixedRows = 2
		    fg.MergeCells = 5
		
        fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Level"
		
        fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Name"
	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Standard"
		
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 3, 0, 11) = "Working(Changed)"  
		fg.Cell(0, 1, 3, 1) 	= "Unit"
		fg.Cell(0, 1, 4, 1 ) 	= "Currency"
		fg.Cell(0, 1, 5, 1) 	= "Qty"
		fg.Cell(0, 1, 6, 1) 	= "Unit Price"
		fg.Cell(0, 1, 7, 1) 	= "Raw Mtrl. Cost U/P"
		fg.Cell(0, 1, 8, 1) 	= "Labor Cost U/P"
		fg.Cell(0, 1, 9, 1) 	= "Exp. U/P"
		fg.Cell(0, 1, 10, 1) 	= "Unit Price"
		fg.Cell(0, 1, 11, 1) 	= "Amount"

        fg.Cell(0, 0, 12, 0, 13) = "Order W. Div."  
		fg.Cell(0, 1, 12, 1) 	= "Code"
		fg.Cell(0, 1, 13, 1 ) 	= "Name"
		
		fg.MergeCol(14) = true
		fg.Cell(0, 0, 14, 1, 14) = "Exec. (Y/N)"
		
		fg.MergeCol(15) = true
		fg.Cell(0, 0, 15, 1, 15) = "Dir. Mgt Outsrc."
		
		fg.MergeCol(16) = true
		fg.Cell(0, 0, 16, 1, 16) = "Budget Code"
		
		fg.MergeCol(17) = true
		fg.Cell(0, 0, 17, 1, 17) = "Standard Code"
		
		fg.MergeCol(18) = true
		fg.Cell(0, 0, 18, 1, 18) = "Calc. Basis"
		
		fg.MergeCol(19) = true
		fg.Cell(0, 0, 19, 1, 19) = "Order Status"
		
		fg.MergeCol(20) = true
		fg.Cell(0, 0, 20, 1, 20) = "A. Rslt Rcpt Y/N"
}
 //---------------------------------------------------------
 function BindingDataList()
 {
    //data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.orderingconttypename  FROM ec111.tecps_orderingconttype a WHERE a.del_if = 0 order by a.pk desc")%>"; 
//    lstOrdWork.SetDataText(data);
    
    var ls_Work_Breakdown = "<%=ESysLib.SetListDataSQL("select pk, UNDERTAKELEVELNAME from ec111.TECPS_UNDERTAKELEVELCODE where del_if = 0 order by UNDERTAKELEVELNAME")%>|ALL|-- ALL --";
    lstWork_Breakdown.SetDataText(ls_Work_Breakdown); 
    lstWork_Breakdown.value = 'ALL'; 
 }

 //---------------------------------------------------------

 //---------------------------------------------------------

 //---------------------------------------------------------

 //---------------------------------------------------------


 //---------------------------------------------------------

 //---------------------------------------------------------

 //---------------------------------------------------------

function OnEntryLevelCode()
{
    var path = System.RootURL + '/form/kp/bp/kpbp00050_popup_level.aspx';
	var aValue = System.OpenModal( path ,1024 , 500 , 'resizable:yes;status:yes');
}
 //-----------------------------------------------------------
 
 //---------------------------------------------------------

//----------------------------------------------------------- 
 //checkKey=================================================

//--------------------------------------------------------------------

//--------------------------------------------------------------------

 //---------------------------------------------------------

</script>

<body>
    <!----------------------------------------------------------------------->
    <!----------------------------------------------------------------------->
    <!-----------------grdCharger ---------------------------------------->
    <!-----------------grdContact ---------------------------------------->
    <!-----------------grdBizplace ---------------------------------------->
    <!-----------------grdLocation ---------------------------------------->
    <!-------------------------------------------------------------------->
    <!-------------------------------------------------------------------->
    <table style="background: #BDE9FF; height: 100%; width: 100%" border="0" id="tableID1" >
        <tr>
           
            <td id="right" style="width: 100%; background:white">
                <table style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="0">
                    <tr style="height: 2%">
                        <td style="width: 100%">
                        	<fieldset style="width:100%">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td align="right" width="10%">
                                                <a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">
                                                    Project&nbsp;</a></td>
                                            <td width="50%">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="40%">
                                                            <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                                                        </td>
                                                        <td width="60%">
                                                            <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                                                        </td>
                                                        <td width="">
                                                            <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                                                        </td>
                                                        <td>
                                                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                                                        </td>
                                                    </tr>
                                                    
                                                </table>
                                     </td>
                                    <td align="right" width="10%"><a title="Direct Management /Outsourcing " style="text-decoration: none;color:#333" >Dir. Mgt/Outsrc.&nbsp;</a></td>
                                      <td width="25%">
                                                            <gw:list id="lstDirect"  styles='width:100%' />
                                                        </td>
                                    
                                    <td style="width: 1%">
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td>
                                                    <gw:imgbtn id="ibnUpdte" img="search" alt="Entry Level Code" onclick="OnEntryLevelCode()" />
                                                </td>
                                                
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                               
                                <tr>
                                			<td align="right" width=""><a title="Click here to show Order Work Division" href="#" style="text-decoration: none" onClick="OnPopUp('')">Order W. Div&nbsp;</a></td>
                                        	<td >
                                            			<table cellpadding="0" cellspacing="0">
                                                        		<tr>
                                                                			
                                                                            <td width="40%">
                                                                                <gw:textbox id="txtOrderWork_Cd" readonly="true" styles='width:100%' />
                                                                            </td>
                                                                            <td width="60%">
                                                                                <gw:textbox id="txtOrderWork_Nm" readonly="true" styles='width:100%' />
                                                                            </td>
                                                                            <td>
                                                                                <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtOrderWork_Cd.text='';txtOrderWork_Nm.text='';" />
                                                                            </td>
                                                                </tr>
                                                        </table>
                                            </td>
                                    		<td  align="right">
                                            <a href="#"  title="Click here to show Work Division"  onClick="" style="text-decoration:none">W. Div</a></td>
                                            <td width="" colspan=""><gw:list id="lstWork_Breakdown" styles="width:100%" /></td>
                                </tr>
                                
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                     <tr style="height: 2%;">
                     			<td>
                                			<table>
                                            			<tr>
                                                        			<td style="width: 10%" align="right">
                                                                        Select Column</td>
                                                                    <td style="width: 20%">
                                                                        <gw:list id="lstColumn" styles="width:100%;" />
                                                                    </td>
                                                                    <td style="width: 5%" align="right">
                                                                        Filter</td>
                                                                    <td style="width: 15%" align="left">
                                                                        <gw:list id="lstFilter" styles="width: 100%" />
                                                                    </td>
                                                                    <td width="20%"><gw:textbox id="txtFilter" styles="width: 100%" /></td>
                                                                    <td style="width: 5%" align="right">Total</td>
                                                                    <td style="width: 25%" ><gw:list id="lstTotal" styles="width: 100%" /></td>
                                                                    <td >
                                                                        <gw:imgbtn id="btnSearchs" img="search" alt="Search" />
                                                                    </td>
                                                                    <td >
                                                                        <gw:imgbtn id="btnRefresh" img="refresh" alt="Refresh" />
                                                                    </td>
                                                        </tr>
                                            </table>
                                </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="7">
                            <!-- <gw:tab id="idTab" > -->
                           
                                    <!--header="Level|Name|Standard|Unit|Currency|Qty|Unit Price|Raw Mtrl. Cost U/P|Labor Cost U/P|Exp. U/P| Unit Price|Amount|Code|Name|Exec. (Y/N)|Dir. Mgt Outsrc.|Budget Code|Standard Code|Calc. Basis|Order Status|A. Rslt Rcpt Y/N"-->
                                        <gw:grid id="Grid2" 
                                        header="0.Level|1.Name|2.Standard|3.Unit|4.Currency|5.Qty|6.Unit Price|7.Raw Mtrl. Cost U/P|8.Labor Cost U/P|9.Exp. U/P|10. Unit Price|11.Amount|12.Code|13.Name|14.Exec. (Y/N)|15.Dir. Mgt Outsrc.|16.Budget Code|17.Standard Code|18.Calc. Basis|19.Order Status|20.A. Rslt Rcpt Y/N" 
                                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|" defaults="|||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths="1200|1000|1000|1000|1000|1000|1000|1000|1200|1000|1000|1000|1000|1000|1000|1000|1000"
                                            styles="width:100%; height:100%" sorting="T" oncelldblclick="OnOpenFile()" />
                                   
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------------------------------------->
    <gw:textbox id="txtPartnerPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtParentPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtBillToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="imagePK" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtPartID" styles='display:none' />
    <gw:textbox id="txtPartNm" styles='display:none' />
    <gw:textbox id="txtTable" text="tco_buspartner" styles='display:none' />
    <gw:textarea id="txtMemo" rows="10" styles="width:100%;display:none" />
    <!----------------------------------------------------------------------------------------->
   
    <!----------------------------------------------------------------------------------------->
</body>
</html>
