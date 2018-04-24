<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("comm")%>
<head>
    <title>Untitled Page</title>
</head>
<script type="text/javascript" language="javascript">
var gAction="";
var OldCode="";
var OldValues = new Array();
//------------------------------------------------------------
function BodyInit()
{
    BindingDataList();
    idData_Dsql_ItemGroupTree.Call("SELECT");
}
//------------------------------------------------------------
function BindingDataList()
{  
     var data = "<%=ESysLib.SetListDataSQL("select pk, wh_id || '-' || wh_name  from inv.tin_warehouse where del_if = 0 and use_yn='Y'")%>";
     lstWH.SetDataText(data);
    <%=ESysLib.SetGridColumnComboFormat ("grdAttribute" , 9 , "SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'COAB0180' AND A.USE_IF = 1" )%>;
}
//-------------------------------------------------------------
function OnTreeClick()
{ 
   var obj = event.srcElement.GetCurrentNode();    
    
   idInputPK.SetDataText(obj.oid);
   txtPK.SetDataText(obj.oid);
   gAction = "";
   grdAttribute.ClearData();
   idData_wcoci00002_1.Call("SELECT");
} 
//-------------------------------------------------------------- 
function OnSave()
{
	if(idITEMGRP_CD.GetData()=="" || idGRP_NM.GetData()=="")
	{
		alert("Group initial and description can not be empty");
		return;
	}
	//idGrid.StatusUpdate();
	idData_wcoci00002_1.Call();
	
}
//---------------------------------------------------------------
function OnAddNew(index)
{
	switch(index)
	{
	    case 0:
	        if(idData_wcoci00002_1.GetStatus()!= 32)
	        {
		        if(txtPK.GetData()=='')
		        {
			        alert("You must choose a parent group to add sub group");
			        return;
		        }
		        if(idLEAF_YN.GetData()=='Y')
		        {
			        alert("You can not add sub group to a leaf group");
			        return;
		        }
        	    SaveOldValues();
		        var tmpINI=idITEMGRP_CD.GetData();
		        idData_wcoci00002_1.StatusInsert();
		        gAction = "INSERT";
		        idP_PK.SetDataText(idInputPK.GetData());
		        idInputPK.SetDataText("");
            }
	        else
	        {
	          alert("You already click new. Now you can input new data.");
	        }
	    break;
	    case 1:
	       grdAttribute.AddRow();
	       grdAttribute.SetGridText(grdAttribute.rows - 1,2,idInputPK.GetData()); 
	    break;
	}
	
}
//----------------------------------------------------------------------
function SaveOldValues()
{
	OldValues[30]=idHS_CODE_PK.GetData();
	OldValues[31]=idHSCODE.GetData();
	OldValues[32]=idITEM_UOM.GetData();
	OldValues[34]=idITEM_UOMWT.GetData();
}
//----------------------------------------------------------------------
function ReDisplayOldValues()
{
	idHS_CODE_PK.SetDataText( OldValues[30]);
	idHSCODE.SetDataText( OldValues[31]);
	idITEM_UOM.SetDataText( OldValues[32]);
	idITEM_UOMWT.SetDataText( OldValues[34]);
}
//---------------------------------------------------------------------
function OnDelete(index) 
{
    switch(index)
    {
        case 0:
            gAction = "DELETE";
	        idData_wcoci00002_1.StatusDelete();
	        idData_wcoci00002_1.Call();
        break;
        case 1:
            grdAttribute.DeleteRow();
        break;
        
    }
    
}
//----------------------------------------------------------------------
function TabPopUp(fnameFile,opt)
{
		var fpath = System.RootURL + "/form/comm/ci/" + fnameFile + "?GrpPK="+idInputPK.GetData();
		if (fnameFile=="wcoci00002.asp")
		{    var aValue  = System.OpenModal(  fpath , 550 , 600 , 'resizable:yes;status:yes');	}
        else
		{    var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');	}
		if ( aValue != null )  
		{
			if (aValue[0] == 'HSCODEPopup.asp') 
			{
				idHS_CODE_PK.SetDataText( aValue[1]);
				idHSCODE.SetDataText(aValue[2]);
			}
			if (aValue[0] == 'UOMPopup.asp') 
			{
				if(opt==0){
					idITEM_UOM.SetDataText( aValue[1]);
					idUNM.SetDataText(aValue[2]);
					} else {
					idITEM_UOMWT.SetDataText( aValue[1]);
					idUWNM.SetDataText(aValue[2]);
					}
				
			}
			if (aValue[0] == 'SPECGRPPopup.asp') 
			{	//alert(aValue[1])
				grdAttribute.SetGridText(grdAttribute.row, 4, aValue[2]);//name	
				grdAttribute.SetGridText(grdAttribute.row, 5, aValue[3]);//lname
				grdAttribute.SetGridText(grdAttribute.row, 3, aValue[1]);//pk	
			}
		}
}
//-----------------------------------------------------
function RefreshTree()
{
	  gAction="";
	  idData_Dsql_ItemGroupTree.Call("SELECT");
}
//----------------------------------------------------
function OnUOMInheritYN(opt, flag)
{
		if(opt==-1)
		{
		 	opt=true;
		 }
		 else
		 {
		 	opt=false;
		 }
		 var obj;
		 idBtn_UOMPOPUP.SetEnable(opt);
		 idBtn_UOMWPOPUP.SetEnable(opt);
		 if(flag==1)
		 {
		   idUNM.SetDataText("");
		   idUWNM.SetDataText("");
		   idITEM_UOM.SetDataText("");
		   idITEM_UOMWT.SetDataText("");
		 }	

}
//--------------------------------------------------------
function OnDataReceive(p_oData)
{
    switch(p_oData.id )
    {
        case "idData_wcoci00002_1":
            idData_wcoci00002_2.Call();
        break;
        case "idData_wcoci00002_2":
             idData_Dsql_ItemGroupTree.Call("SELECT");
        break;
        case "idData_wcoci00003":
            if(gAction == "INSERT" || gAction == "DELETE")
            {
                 RefreshTree();
            }
        break;
    }
 }

//--------------------------------------------------------
function  OnSubUndelete()
{
   grdAttribute.UnDeleteRow();
}
//--------------------------------------------------------
function OnGridCellDoubleClick(p_oGrid)
{
	//alert(event.col)
  if(p_oGrid.id == "grdAttribute" && event.col <=5)
  {
     TabPopUp('wcoci00002_1.aspx');
  }
}
//--------------------------------------------------------
function Upcase()
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
//-------------------------------------------------------
</script>
<body>
    <!------------------------------------------------------------------------------->
    <gw:data id="idData_Dsql_ItemGroupTree" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" user="comm" function="comm.sp_get_ItemGroupTree" > 
                <input />
                <output bind="oTree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
     <gw:data id="idData_wcoci00002_1"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="control" parameter = '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32' user="comm" function="comm.sp_get_ItemgrpDetail" procedure = "comm.sp_ItemGrp_entry"> 
                <input>
                    <input  bind="txtPK" /> 
                    <input  bind="idP_PK" />
                    <input  bind="idITEMGRP_CD" /> 
                    <input  bind="idGRP_NM" /> 
				    <input  bind="idGRP_LNM" />
				    <input  bind="idGRP_FNM" />
				    <input  bind="idITEM_FORMAT" /> 
                    <input  bind="idITEM_UOM" /> 
                    <input  bind="idITEM_UOMWT" /> 
                    <input  bind="idITEM_UOMVOL" />
                    <input  bind="idITEM_UOMDIM" />
                    <input  bind="idITEM_UOMSUR" />
                    <input  bind="idPROD_YN" />
                    <input  bind="idSALE_YN" />
                    <input  bind="idPUR_YN" />
                    <input  bind="idLEAF_YN" /> 
                    <input  bind="idHS_CODE_PK" /> 
                    <input  bind="idHSCODE" />
                    <input  bind="idHS_LEVEL" /> 
                    <input  bind="lstWH" /> 
                    <input  bind="idacccode" />
                    <input  bind="idPUR_TYPE" />
                    <input  bind="idWEIGHT_FORMULAR" />
                    <input  bind="idVOLUME_FORMULAR" />
                    <input  bind="idSURFACE_FORMULA" />
                    <input  bind="idID_FORMULA" />
                    <input  bind="chkSPEC_UNIQUE_YN" />
				    <input  bind="txtSTSeqLength" />
				    <input  bind="txtItemSeqLength" />
				    <input  bind="chkPATTERN_YN" />
				    <input  bind="idDESCRIPTION" />
				    <input  bind="idUSE_YN" />
				    <input  bind="idST_DATE" />
				    <input  bind="idEND_DATE" />
                </input>
                <output>
	                <output bind="txtPK" /> 
	            </output>
            </dso> 
        </xml>
    </gw:data> 
    <!-----------------grdAttribute ---------------------------------------->
     <gw:data id="idData_wcoci00002_2"  onreceive="OnDataReceive(this)" > 
            <xml> 
               <dso id="1" type="grid" user="comm" parameter="0,1,2,3,6,7,8,9,10" function="comm.sp_get_tco_grpspecgrp"  procedure="comm.sp_tco_cigrpspecgrp_entry"> 
                    <input bind="grdAttribute" > 
                        <input bind="txtPK" /> 
                    </input> 
                    <output bind="grdAttribute" /> 
                </dso> 
            </xml> 
    </gw:data> 
   <!---------------------------------------------------------------------->
    
<table width=100% cellpadding=0 cellspacing=0 border=1>
	<tr>
		<td width="25%" rowspan="2" valign="top">
			<table id="LeftBottomTB" width="100%" valign="top">
				<tr>
					<td><gw:tree   ID = "oTree" style="width:100%; height:490;overflow:auto;" onclicknode="OnTreeClick()" /><!-- Master Grid Control here. Remember add this function oncellclick="RowClick()"--> </td>
				</tr>
			</table>						
		</td>
		
    <td width="75%" align="center"> 
      <table width="99%" cellspacing="3">
        <tr>
            <td>
               <table border = "0">
                <tr>
                    <td width= "97%">
                       &nbsp;
                    </td>
                    <td width= "1%">
                        <gw:imgBtn id="idBtnNew" img="new" alt="New" text="New" onclick="OnAddNew(0)"/>
                    </td>
                    <td width= "1%">
                        <gw:imgBtn id="idBtnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete(0)"/>
                    </td>
                    <td width= "1%">
                        <gw:imgBtn id="idBtnUpdate" img="save" alt="Save" text="Save" onclick="OnSave()"/>
                    </td>
                </tr>
               </table> 
            </td>
        </tr>
        <tr> 
          <td><table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#81d7f3" style="border-collapse: collapse">
              <tr> 
                <td>
                <table width="100%" height="20" cellpadding="2" cellspacing="0" id="RightTopTB">
                    <tr> 
                      <td width="15%" bgcolor=""><font color="black" ><b>Group code&nbsp;</b></font></td>
                      <td width="20%" bgcolor=""><gw:textbox csstype="mandatory" id="idITEMGRP_CD" styles='width:100%' maxlen=20 onkeypress ="Upcase()" /></td>
                      <td width="15%" bgcolor=""><font color="black" ><b>Group name&nbsp;</b></font></td>
                      <td width="20%" bgcolor=""><gw:textbox csstype="mandatory" id="idGRP_NM" styles='width:100%' maxlen=40 /></td>
                      <td width = "45%"></td>
                    </tr>
                    <tr>
                      <td width="15%" bgcolor=""><font color="black" ><b>Name local&nbsp;</b></font></td>
                      <td width="20%" bgcolor=""><gw:textbox  id="idGRP_LNM" styles='width:100%' maxlen=40 /></td>
                      <td width="15%" bgcolor=""><font color="black" ><b>Name foreign&nbsp;</b></font></td>
                      <td width="65%" bgcolor=""><gw:textbox  id="idGRP_FNM" styles='width:100%' maxlen=40 /></td>
                      
                    </tr>
                  </table>
                  </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
            <td>
               <table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#81d7f3" style="border-collapse: collapse">
                <tr>
                    <td>
                        <table width="100%" height="20" cellpadding="2" cellspacing="0" id="Table2">
                            <tr>
                                <td width="15%" bgcolor=""><b>Item format</b></td>
                                <td width="20%" bgcolor=""><gw:textbox  id="idITEM_FORMAT" styles='width:100%' maxlen=40 /></td>
                                <td width="15%" bgcolor=""><b>Item UOM</b></td>
                                <td width="20%" bgcolor=""><gw:textbox id="idITEM_UOM" styles='width:100%' maxlen=40 /></td>
                                <td width="15%" bgcolor=""><b>UOM vol</b></td>
                                <td width="20%" bgcolor=""><gw:textbox id="idITEM_UOMVOL" styles='width:100%' maxlen=40 /></td>
                                
                            </tr>
                            <tr>
                                <td width="15%" bgcolor=""><b>UOM dim</b></td>
                                <td width="20%" bgcolor=""><gw:textbox  id="idITEM_UOMDIM" styles='width:100%' maxlen=40 /></td>
                                <td width="15%" bgcolor=""><b>UOM sur</b></td>
                                <td width="50%" bgcolor="" colspan = 3><gw:textbox  id="idITEM_UOMSUR" styles='width:100%' maxlen=40 /></td>
                                
                            </tr>
                        </table>
                    </td>
                </tr>
                
               </table> 
            </td>   
          
        </tr>
        <tr>
            <td>
                <table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#81d7f3" style="border-collapse: collapse">
                 <tr>
                    <td>
                        <table width="100%" height="20" cellpadding="2" cellspacing="0" id="Table3">
                            <tr>
                                <td width="12%" bgcolor=""><b>Product YN</b></td>
                                <td width="12%" bgcolor=""><gw:checkbox id="idPROD_YN" mode="01" ></gw:checkbox></td>
                                <td width="12%" bgcolor=""><b>Sale YN</b></td>
                                <td width="12%" bgcolor=""><gw:checkbox id="idSALE_YN" mode="01" onchange="OnUOMInheritYN(this.GetData(),1)"></gw:checkbox></td>
                                <td width="12%" bgcolor=""><b>Purchase YN</b></td>
                                <td width="12%" bgcolor=""><gw:checkbox id="idPUR_YN" mode="01" ></gw:checkbox></td>
                                <td width="12%" bgcolor=""><b>Leaf YN</b></td>
                                <td width="12%" bgcolor=""><gw:checkbox id="idLEAF_YN" mode="01" ></gw:checkbox></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                    
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#81d7f3" style="border-collapse: collapse">
                   <tr>
                    <td>
                        <table width="100%" height="20" cellpadding="2" cellspacing="0" id="Table4">
                            <tr>
                        <td width="15%" bgcolor=""><b>Purchase type</b></td>
                        <td width="35%" bgcolor=""><gw:textbox id="idPUR_TYPE" styles='width:100%' maxlen=40 /></td>
                        <td width="15%" bgcolor=""><b>Weight formula</b></td>
                        <td width="35%" bgcolor="" colspan = 3><gw:textbox id="idWEIGHT_FORMULAR" styles='width:100%' maxlen=40 /></td>
                    </tr>
                    <tr>
                        <td width="15%" bgcolor=""><b>Volume formula </b></td>
                        <td width="35%" bgcolor=""><gw:textbox id="idVOLUME_FORMULAR" styles='width:100%' maxlen=40 /></td>
                        <td width="15%" bgcolor=""><b>Surface formula</b></td>
                        <td width="35%" bgcolor="" colspan = 3><gw:textbox id="idSURFACE_FORMULA" styles='width:100%' maxlen=40 /></td>
                    </tr>
                    <tr>
                        <td width="15%" bgcolor=""><b>Id formula</b></td>
                        <td width="35%" bgcolor=""><gw:textbox id="idID_FORMULA" styles='width:100%' maxlen=40 /></td>
                        <td width="15%" bgcolor=""><b>Spec unique YN </b></td>
                        <td width="2%" bgcolor=""><gw:checkbox id="chkSPEC_UNIQUE_YN" mode="01"></gw:checkbox></td>
                        <td width="18%" bgcolor=""><b>Seq length(st/item)</b></td>
                        <td width="15%" bgcolor=""><gw:textbox id="txtSTSeqLength" styles="width:49%" /><gw:textbox id="txtItemSeqLength" styles="width:50%" /></td>
                    </tr>
                    <tr>
                        <td width="15%" bgcolor=""><b>HS code level</b></td>
                        <td width="35%" bgcolor=""><gw:textbox id="idHS_LEVEL" /></gw:textbox></td>
                        <td width="15%" bgcolor=""><b>HS code</b></td>
                        <td width="35%" bgcolor="" colspan = 3><gw:textbox id="idHSCODE" styles='width:100%'/></td>
                    </tr>
                     <tr>
                        <td width="15%" bgcolor=""><b>Account code</b></td>
                        <td width="35%" bgcolor="">
                            <table width = "100%" cellpadding = "0">
                                <tr>
                                    <td width = "99%"><gw:textbox id="idacccode" /></gw:textbox><gw:textbox id="idaccname" /></gw:textbox></td>
                                    <td wdith = "1%"><gw:imgBtn id="ibtnpopupacc" img="popup" alt="popup" onclick=""/></td>
                                </tr>
                            </table>
                        </td>
                        <td width="15%" bgcolor=""><b>Warehouse</b></td>
                        <td width="35%" bgcolor="" colspan = 3><gw:list id="lstWH" styles="width:100%" value="9"></gw:list></td>
                    </tr>
                        </table>
                    </td>
                   </tr>
                    
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#81d7f3" style="border-collapse: collapse">
                   <tr>
                    <td>
                        <table width="100%" height="20" cellpadding="2" cellspacing="0" id="Table5">
                            <tr>
                                <td width="15%" bgcolor=""><b>Pattern YN</b></td>
                                <td width="10%" bgcolor=""><gw:checkbox id="chkPATTERN_YN" mode="01"></gw:checkbox></td>
                                <td width="15%" bgcolor=""><b>Active YN</b></td>
                                <td width="10%" bgcolor=""><gw:checkbox id="idUSE_YN" mode="01"></gw:checkbox></td>
                                <td width="15%" bgcolor=""><b>Start date</b></td>
                                <td width="10%" bgcolor=""><gw:textbox id="idST_DATE" /></td>
                                <td width="15%" bgcolor=""><b>End date</b></td>
                                <td width="10%" bgcolor=""><gw:textbox id="idEND_DATE" /></td>
                            </tr>
                            <tr>
                                <td width="15%" bgcolor=""><b>Description</b></td>
                                <td width="85%" bgcolor="" colspan = 7><gw:textbox id="idDESCRIPTION"  styles='width:100%'></gw:textbox></td>
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
	<tr valign="top" >
		
		
    <td width="75%" align="center"> 
      <table width="99%" border="0" cellspacing="0" cellpadding="0">
      <tr>
            <td width = "100%" >
                <table width=100% >
                     <tr> 
                         <td width=97%></td>
						 <td width=1%><gw:imgBtn id="ibtnSubNew" img="new" alt="New" onclick="OnAddNew(1)"/></td>
						 <td width=1%><gw:imgBtn id="ibtnSubDelete" img="delete" alt="Delete"  onclick="OnDelete(1)"/></td>
						 <td width=1%><gw:imgBtn id="ibtnSubUndelete" img="udelete" alt="Undelete"  onclick="OnSubUndelete()"/></td>
					</tr>
                </table>
            </td>
        </tr>
        <tr>
          <td><table width="100%" border="1" cellpadding="0" cellspacing="1" bordercolor="#81d7f3" style="border-collapse: collapse">
              <tr> 
                <td bgcolor="#FFFFFF"><table width="100%" cellpadding="1" cellspacing="0" bordercolor="#FFFFFF" id="RightBottomTB"  valign="top" >
                    
                    <tr>
                        <td colspan=6>
                            <table width=100%>
                                 <tr> 
                                     <td>
                                           <gw:grid
                                            id="grdAttribute"
                                            header="_pk|No|_cigrp_pk|_cispecgrp_pk|Group spec name|Local name|Mandatory|Active|Seq Auto|Spec type|Prefix sign"
                                            format="0|0|0|0|0|0|3|3|3|2|0"
                                            aligns="0|0|0|0|0|0|3|3|0|0|0"
                                            defaults="|||||||-1|_1|ST|"
                                            editcol="0|1|1|1|1|1|1|1|1|1|1"
                                            widths="0|600|0|0|2500|2500|1500|1500|1500|1500|1000"
                                            styles="width:100%; height:150"
                                            sorting="F"
                                            oncelldblclick="OnGridCellDoubleClick(this)"
                                            param="0,1,2,3,4,5,6,7,8,9,10"  />
                                       
                                     </td>
								</tr>
                            </table>
                        </td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table> 
    </td>
	</tr>	
</table>

<gw:textbox id="txtPK" style="display:none" /> 
<gw:textbox id="idP_PK" style="display:none" /> 
<gw:textbox id="idINHERIT_PK" style="display:none" /> 
<gw:textbox id="idUOM_INHERIT_PK" style="display:none" />

<gw:textbox id="idITEM_UOMWT" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK1" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK2" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK3" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK4" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK5" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK6" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK7" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK8" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK9" style="display:none" /> 
<gw:textbox id="idTCO_CISPECGRP_PK10" style="display:none" />
<gw:textbox id="idHS_CODE_PK" style="display:none" /> 
<gw:textbox id="idInputPK" style="display:none" />
<gw:textbox id="idCountG" style="display:none" />
</body>
</html>
