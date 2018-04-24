<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Caddy Entry</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>

var G1_PK               = 0,
    G1_ID       = 1,
    G1_Name         = 2,
    G1_LName      = 3;
var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
//-----------------------------------------------------------------------------------------
function BodyInit()
{   
    
    //----------------------------------------
    var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, CODE||'-'||NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CDEVAL'" )%>";
    grdCaddiesDtl.SetComboFormat(3,data);// Customer service/ attitude
	grdCaddiesDtl.SetComboFormat(4,data);// |Course knowledge
	grdCaddiesDtl.SetComboFormat(5,data);// |Caddy skill & Golf rules
	grdCaddiesDtl.SetComboFormat(6,data);// |English skill
	grdCaddiesDtl.SetComboFormat(7,data);//|Repair pitch mark,divot, rake bunker
	
	grdCaddiesDtl.GetGridControl().WordWrap = true;
	grdCaddiesDtl.GetGridControl().RowHeight(0) = 650 ;
	OnSearch();
}

//-----------------------------------------------------------------------------------------
function onClick()
{      
    txtMasterPK.SetDataText(grdCaddy.GetGridData(grdCaddy.row, G1_PK));
   // alert(txtMasterPK.text);
    dso_dCaddiesDtl.Call('SELECT');
    
}
//-----------------------------------------------------------------------------------------
function OnSearch()
{
  data_jacd0010.Call("SELECT");
}
function OnNew()
{
	if(txtMasterPK.text!="")
	{
		grdCaddiesDtl.AddRow();
		grdCaddiesDtl.SetGridText(grdCaddiesDtl.rows - 1, 1, txtMasterPK.text);//caddies pk 
	}
	else
	{
		alert("Please,choose caddies to add new!!!!");
	}
}
function OnDelete()
{
	if(txtMasterPK !="")
	{
		if(grdCaddiesDtl.row !='-1')
		{
			if(confirm("Do you want to delete ?"))
			{
				grdCaddiesDtl.DeleteRow();
				dso_dCaddiesDtl.Call();
			}
		}
	}
}
function OnSave()
{
	 if(CheckDataIsValid())
		{
			dso_dCaddiesDtl.Call();
		}
}
function CheckDataIsValid()
{
    for(var i=1;i<grdCaddiesDtl.rows;i++)
    {
        if(grdCaddiesDtl.GetGridData(i,2)=="")//date
        {
            alert("Please choose date at row "+i);
            return false;
        }
		if(grdCaddiesDtl.GetGridData(i,3)=="")//Customer service/ attitude
        {
            alert("Please choose Customer service/ attitude at row "+i);
            return false;
        }
    }
   return true;
}
function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");       
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 function SetGrdColor()
 {
	if(grdCaddiesDtl.rows >1)
	{
		var ctrl 	= grdCaddiesDtl.GetGridControl();
			for (i=1; i<ctrl.Rows; i++)
			{
				
			    if (grdCaddiesDtl.GetGridData(i,8)== "5" || grdCaddiesDtl.GetGridData(i,8)== "6"|| grdCaddiesDtl.GetGridData(i,8)== "7"|| grdCaddiesDtl.GetGridData(i,8)== "8"|| grdCaddiesDtl.GetGridData(i,8)== "9"|| grdCaddiesDtl.GetGridData(i,8)== "10")
				{
					grdCaddiesDtl.SetCellBgColor(i,8,i,8, Number('0X3333CC'));
				}
				else if (grdCaddiesDtl.GetGridData(i,8)== "11" || grdCaddiesDtl.GetGridData(i,8)== "12"|| grdCaddiesDtl.GetGridData(i,8)== "13"|| grdCaddiesDtl.GetGridData(i,8)== "14"|| grdCaddiesDtl.GetGridData(i,8)== "15")
				{
					grdCaddiesDtl.SetCellBgColor(i,8,i,8, Number('0X00CCCC'));
				}
				else if (grdCaddiesDtl.GetGridData(i,8)== "16" || grdCaddiesDtl.GetGridData(i,8)== "17"|| grdCaddiesDtl.GetGridData(i,8)== "18"|| grdCaddiesDtl.GetGridData(i,8)== "19"|| grdCaddiesDtl.GetGridData(i,8)== "20")
				{
					grdCaddiesDtl.SetCellBgColor(i,8,i,8, Number('0XCC9933'));
				}
				else if (grdCaddiesDtl.GetGridData(i,8)== "21" || grdCaddiesDtl.GetGridData(i,8)== "22"|| grdCaddiesDtl.GetGridData(i,8)== "23"|| grdCaddiesDtl.GetGridData(i,8)== "24"|| grdCaddiesDtl.GetGridData(i,8)== "25")
				{
					grdCaddiesDtl.SetCellBgColor(i,8,i,8, Number('0XFFFFFF'));
				}
				else 
				{
					grdCaddiesDtl.SetCellBgColor(i,8,i,8, Number('0XFFFFFF'));//3 00CCFF
				}
				
			}
	}	
 }
function OnDataReceive(obj)
{
	if(obj.id=="dso_dCaddiesDtl")
		{
			SetGrdColor();
		}

}
</script>

<body>
    <!---------------------------------------------------------------------------------->
    <gw:data id="data_jacd0010" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jacd0090" > 
                <input bind="grdCaddy" >
                    <input bind="txtCName" />
                    <input bind="chkActiveYN" />    
                    <input bind="chkPART_TIME_YN" /> 
                </input>
                <output bind="grdCaddy" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------>
	<gw:data id="dso_dCaddiesDtl" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="CRM.sp_sel_jacd0090_dtl" procedure="CRM.sp_upd_jacd0090_dtl">  
                <input bind="grdCaddiesDtl">  
                    <input bind="txtMasterPK" />  															
                </input> 
                <output bind="grdCaddiesDtl" /> 
            </dso> 
        </xml> 
    </gw:data>
	<!--------------------------------------------------->
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr>
            <td style="background: white; width: 30%" id="idLEFT">
                <table style="height: 100%; width: 100%">
                   <tr style="height: 1%"></tr>
                    <tr style="height: 1%">
                        <td style="width: 24%" align="right">
                            Active</td>
                        <td style="white-space: nowrap;width:5%"  >
                            <gw:checkbox id="chkActiveYN"  defaultvalue="Y|N" value="Y" />
                        </td>
                        <td style="width: 50%" align="right">
                            Part time</td>
                        <td style="white-space: nowrap;width:5%" colspan="1"  >
                            <gw:checkbox id="chkPART_TIME_YN"  defaultvalue="Y|N" value="N" />
                        </td>
                        <td style="width: 15%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td >
                            Caddy</td>
                        <td  colspan ="2" >
                            <gw:textbox id="txtCName" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td align="right" colspan="3" >
                            <b style="color: Blue; cursor: hand">
                                <gw:label id="lbRecord">record(s)</gw:label>
                            </b>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="6">
                            <gw:grid id="grdCaddy" header='_pk|Caddy No|Full Name|Phone'
                                format='0|0|0|0' aligns='0|0|0|0' defaults='|||'
                                editcol='0|0|0|0' widths='0|1500|2000|2000' autosize="T"
                                sorting='T'  styles="width:100%;height:100%" 
                                oncellclick="onClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="background: white; width: 70%" id="idRIGHT">
                <table style="height: 100%; width: 100%" border="0">
                    <tr style="height: 2%">
                        <td style="width: 100%">
                            <table style="height: 100%; width: 100%">
                                <tr>
									<td style="width: 8%">
										
                                    </td>
									<td style="width: 3%"></td>
									<td style="width: 80%">
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnAddNewM" img="new" alt="New" onclick="OnNew(this)" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnDeleteM" img="delete" alt="Delete" onclick="OnDelete(this)" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave(this)" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%" valign="top">
                        <td colspan="">
                           <gw:grid id="grdCaddiesDtl" header='_pk|_caddies_pk|Date|Customer service/ attitude|_Courseknowledge|_CaddyskillGolfrules|_Englishskill|_Repairpitchmarkdivotrakebunker|_Total|_Description'
                                format='0|0|4|0|0|0|0|0|0|0' 
								aligns='0|0|0|0|0|0|0|0|1|0' 
								defaults='|||||||||'
                                editcol='0|0|1|1|1|1|1|1|1|1' 
								widths='0|0|1300|1300|1300|1300|1300|1300|1300|1800' 
                                sorting='T'  styles="width:100%;height:100%" acceptNullDate="T" 
                                 />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />    
    
    <gw:textbox id="txtMasterPK" styles="display:none" />
    <gw:textbox id="txtItemPhotoPK" styles="display:none" />
    
    <gw:textbox id="txtCaddy_Eva" styles="display:none" />
    <gw:textbox id="txtEmp_PK" styles="display:none" />
    <!---------------------------------------------------------------------->
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  