<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>ST Item Spec Mapping</title>
  </head>
 <%ESysLib.SetUser("comm")%>
 <script>
 function BodyInit()
 {
    BindingDataList();
 }
  //---------------------------------------------------------
 function BindingDataList()
 {   
     var data1 = "<%=ESysLib.SetListDataSQL("select distinct(p.pk),p.grp_nm from tco_itemgrp p where p.del_if = 0 and p.leaf_yn='Y' and p.pk in (select distinct(tco_itemgrp_pk) from tco_grpspecgrp g where g.del_if =0 and g.spec_type<>'ST')")%>";   
     //var data2 ="<%=ESysLib.SetListDataSQL("select   c.pk, c.specgrp_nm from tco_grpspecgrp b, tco_specgrp c where b.tco_specgrp_pk = c.pk and b.del_if = 0 and c.del_if = 0 and b.spec_type <> 'ST'")%>";
     var data2 ="DATA|-1|----";
     cboGROUP.SetDataText(data1);
     cboSPEC_GROUP.SetDataText(data2);
 }
 //---------------------------------------------------------
 //-------------------------------------------------------------- 
function OnDataReceive(p_oData)
{
}
function receiveStItemspec()
{
     lblRowCount.SetDataText(""+(grdTco_StItemSpec.rows -1));
}
function receiveStItem()
{  
    idData_spec_list.Call('');
}
function receiveSpecList()
{
    cboSPEC_GROUP.ClearData();
    cboSPEC_GROUP.SetDataText(txtSpecGroupList.text);
}
//--------------------------------------------------------
function SearchOnClick()
{
    if (txtStItem_PK.text =="")
   {
        alert("Please select Item on the left first !");
        return;
   } 
    grdTco_StItemSpec.ClearData();
    idData_stitemspec.Call("SELECT");
}
//--------------------------------------------------------
function Upcase()
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
//-------------------------------------------------------
function SearchStItem()
{
    grdTCO_STITEM.ClearData();
   grdTCO_SPEC.ClearData();  
    idData_stitem.Call("SELECT");
}
//-------------------------------------------------------
function SearchSpec()
{
    grdTCO_SPEC.ClearData();
    idData_spec.Call("SELECT");
}
//-------------------------------------------------------
function OnGridStItemClick(object)
{
    if(event.row >0)
   {
        //alert('pk='+grdTCO_STITEM.GetGridData(event.row,0));
        txtStItem_PK.text =""+grdTCO_STITEM.GetGridData(event.row,0);
        txtStItem_Group_PK.text =""+grdTCO_STITEM.GetGridData(event.row,3);
        SearchOnClick();
   } 
}
//-------------------------------------------------------
function OnGridSpecDoubleClick(object)
{
    var r_pk="";
    var r_specId ="";
    var r_specName = "";
    var r_group ="";
    var r_client ="";
    var r_rows ="";
    if (txtStItem_PK.text=="")
   {
            alert("Please select an item first!");
            return;
   } 
    if((event.row >0) && (txtStItem_PK.text !=""))
   { 
      r_pk = grdTCO_SPEC.GetGridData(event.row,0);
      r_specId = grdTCO_SPEC.GetGridData(event.row,1);
      r_specName = grdTCO_SPEC.GetGridData(event.row,2);
      r_group =  grdTCO_SPEC.GetGridData(event.row,3);
      r_client =  grdTCO_SPEC.GetGridData(event.row,4);
//       alert('pk='+r_pk+'-'+r_group+'-'+r_client); 
       r_check = 0;
      for(i=1;i<grdTco_StItemSpec.rows;i++)
     {
            if ((grdTco_StItemSpec.GetGridData(i,1)== txtStItem_PK.text) &&(grdTco_StItemSpec.GetGridData(i,2)==r_pk))
            {
                r_check =1;
            }
     }
     if (r_check==0)
     {
              grdTco_StItemSpec.AddRow();
               r_rows = ""+(grdTco_StItemSpec.rows -1);  
               grdTco_StItemSpec.SetGridText(r_rows,1,txtStItem_PK.text);//StItem_PK
              grdTco_StItemSpec.SetGridText(r_rows,2,r_pk);
              grdTco_StItemSpec.SetGridText(r_rows,3,r_specId);
              grdTco_StItemSpec.SetGridText(r_rows,4,r_specName);
              grdTco_StItemSpec.SetGridText(r_rows,5,r_group);
              grdTco_StItemSpec.SetGridText(r_rows,6,r_client); 
      }
   } 
}
//-------------------------------------------------------
function onSaveClick()
{
    // grdTco_StItemSpec.StatusUpdate();
   if (confirm("Do you want to save?"))
    {
        grdTco_StItemSpec.SetRowStatus (0,0);  
        idData_stitemspec.Call('');
      }
}
//-------------------------------------------------------
function onDeleteClick()
{
if (confirm("Do you want to delete this record ?"))
    {
        grdTco_StItemSpec.DeleteRow();
        idData_stitemspec.Call('');
      }
}
//-------------------------------------------------------
function OnGetClient(index)
{
        var fpath = System.RootURL + "/form/ag/ec/agec00010_p.aspx";
        oValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');

        if ( oValue != null)
        {
            if (index==0)
            {
                    txtClient.text = oValue[1]+'-'+oValue[2];
            }
            else 
            {
                      txtCLIENT_H.text = oValue[1]+'-'+oValue[2];
            }
           // txtParentPk.SetDataText(]);
            //txtParCom.SetDataText(oValue[2]);
        }
        
}

function OnError(object)
{
    alert(object.id+"-"+object.errmsg);
}

function onAutoClick()
{
    if (txtStItem_PK.text=="")
   {
         alert("Please select Item first !");
        return;
   }
    
    if (confirm("Do you want to generate this item ?"))
   {
        idData_stitemspec_auto.Call('');
   } 
}
function onChangeGroupItem()
{
  txtStItem_PK.text ="";
  txtStItem_Group_PK.text ="";
  lblRowCount.text ="";
  grdTco_StItemSpec.ClearData();
  SearchStItem();
}

</script> 
<body style="margin:0px;padding:0px;">
 <!-----------------grdTCO_STITEM ---------------------------------------->
     <gw:data id="idData_stitem"  onreceive="receiveStItem()" > 
            <xml> 
               <dso id="1" type="grid" user="comm" parameter="0,1,2" function="comm.sp_sel_stitem"  > 
                    <input bind="grdTCO_STITEM" > 
                        <input bind="txtITEM_CODE" /> 
                        <input bind="cboGROUP" />
                    </input> 
                    <output bind="grdTCO_STITEM" /> 
                </dso> 
            </xml> 
    </gw:data> 
    <!-----------------grdTCO_SPEC ---------------------------------------->
     <gw:data id="idData_spec"  onreceive="OnDataReceive(this)" > 
            <xml> 
               <dso id="2" type="grid" user="comm" parameter="0,1,2,3,4" function="comm.sp_sel_spec"  > 
                    <input bind="grdTCO_SPEC" > 
                        <input bind="txtClient" /> 
                        <input bind="cboSPEC_GROUP" />
                    </input> 
                    <output bind="grdTCO_SPEC" /> 
                </dso> 
            </xml> 
    </gw:data> 
    <!-----------------idData_stitemspec ---------------------------------------->
     <gw:data id="idData_stitemspec"  onreceive="receiveStItemspec()" > 
            <xml> 
               <dso id="3" type="grid" user="comm" parameter="0,1,2" function="comm.sp_sel_stitemspec"  procedure = "comm.sp_upd_stitemspec"> 
                    <input bind="grdTco_StItemSpec" > 
                        <input bind="txtCLIENT_H" /> 
                        <input bind="txtSPEC_H" />
                        <input bind="txtStItem_PK" /> 
                    </input> 
                    <output bind="grdTco_StItemSpec" /> 
                </dso> 
            </xml> 
    </gw:data> 
<!----------------------------------------------------------------------> 
<gw:data id="idData_stitemspec_auto"  onreceive="OnDataReceive(this)" onerror="OnError(this)" > 
            <xml> 
               <dso id="3" type="process" user="comm" parameter="0,1"  procedure = "comm.sp_prc_stitemspec_2item"> 
                    <input >
                        <input bind="txtStItem_Group_PK" />
                        <input bind="txtStItem_PK" /> 
                    </input>
                    <output>
                        <output bind="txtAuto_PK" /> 
                    </output>
                </dso> 
            </xml> 
    </gw:data> 
   
   <gw:data id="idData_spec_list"  onreceive="receiveSpecList()" onerror="OnError(this)" > 
            <xml> 
               <dso id="4" type="process" user="comm" parameter="0"  procedure = "comm.sp_prc_specnst"> 
                    <input >
                        <input bind="cboGROUP" />
                    </input>
                    <output>
                        <output bind="txtSpecGroupList" /> 
                    </output>
                </dso> 
            </xml> 
    </gw:data>  
<!----------------------------------------------------------------------> 
    <table border="2"  width="100%" id="Table1" cellpadding="0" cellspacing="0" >
       <tr valign="top">
            <td width="30%">
                <table border="0" width="100%" style="background:#FFFFFF;">
                    <tr>
                            <td  width="30%"><b>&nbsp;&nbsp;Group </b></td>
                            <td width="65%"><gw:list id="cboGROUP"   styles="width:98%;"  onchange="onChangeGroupItem()"></gw:list></td> 
                          <td width="5%"><gw:imgBtn id="ibtnSearchGroup" img="search" alt="Search" text="Search"  onclick="SearchStItem()" /></td>
                         </tr>
                         <tr>
                            <td ><b>&nbsp;&nbsp;Item </b></td>
                           <td ><gw:textbox id="txtITEM_CODE" styles='width:98%'  onenterkey="SearchStItem()" onkeypress ="Upcase()"  /></td> 
                            <td ><gw:imgBtn id="ibtnAuto" img="auto" alt="Auto Generate Item" text="Auto Generate Item"  onclick="onAutoClick()" /></td> 
                         </tr> 
                        <tr>
                            <td colspan="3">
                                <gw:grid
                                id="grdTCO_STITEM"
                                header="_pk|Item Code|Item Name|_tco_itemgrp_pk"
                                format="0|0|0|0"
                                aligns="0|0|0|0"
                                defaults="||||"
                                editcol="0|0|0|0"
                                widths="0|1500|2000|0"
                                styles="width:97%; height:180"
                                sorting="F"
                                oncellclick="OnGridStItemClick(this)"
                                param="0,1,2,3"  />
                            </td>
                        </tr> 
                        <tr>
                            <td ><b>&nbsp;&nbsp;Spec Group </b></td>
                            <td ><gw:list id="cboSPEC_GROUP"   styles="width:98%;" onchange="SearchSpec()"></gw:list></td> 
                           <td ></td> 
                         </tr>
                         <tr>
                            <td ><b style="color: #1b2ff2; cursor: hand" onclick="OnGetClient(0)">&nbsp;&nbsp;Client </b></td>
                           <td ><gw:textbox id="txtClient" styles='width:98%'  onenterkey="SearchSpec()" onkeypress ="Upcase()"  /></td> 
                             <td ><gw:imgBtn id="ibtnSearchSpecGroup" img="search" alt="Search" text="Search"  onclick="SearchSpec()" /></td> 
                         </tr> 
                        <tr>
                            <td colspan="3">
                                <gw:grid
                                id="grdTCO_SPEC"
                                header="_pk|Spec ID|Spec Name|_SpecGroupName|_PartnerId"
                                format="0|0|0|0|0"
                                aligns="0|0|0|0|0"
                                defaults="|||||"
                                editcol="0|0|0|0|0"
                                widths="0|1500|2000|0|0"
                                styles="width:97%; height:185"
                                sorting="F"
                                oncelldblclick="OnGridSpecDoubleClick(this)"
                                param="0,1,2,3,4"  />
                            </td>
                        </tr> 
                </table>        
            </td> 
            <td width="70%">
                    <table border="0" cellpadding="2"  cellspacing="0"  style="background:#FFFFFF;">
                        <tr>
                                <td  width="10%"><b>&nbsp;&nbsp;Spec </b></td>
                                <td width="30%"><gw:textbox id="txtSPEC_H" styles='width:100%'  onenterkey="SearchOnClick()" onkeypress ="Upcase()"  /></td>
                                <td  align="right" width="10%"><b style="color: #1b2ff2; cursor: hand" onclick="OnGetClient(1)">&nbsp;&nbsp;Client </b></td>
                                <td  colspan="2" width="40%"><gw:textbox id="txtCLIENT_H" styles='width:98%'  onenterkey="SearchOnClick()" onkeypress ="Upcase()"  /></td>
                                <td width="3%" align="right"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="SearchOnClick()" /></td>
                                <td width="3%" align="right"><gw:imgBtn id="ibtnDelete" img="delete" alt="Delete" text="Delete"  onclick="onDeleteClick()" /></td>
                                <td width="4%" align="right"><gw:imgBtn id="ibtnSave" img="save" alt="Save" text="Save"  onclick="onSaveClick()" /></td>
                            </tr> 
                           <tr>
                           <td ><b>&nbsp;&nbsp;Rows </b></td>
                                <td><gw:label id="lblRowCount" styles='width:100%'></gw:label></td>
                                 <td colspan="6"></td>
                           </tr> 
                           <td colspan="8">
                                 <gw:grid
                                id="grdTco_StItemSpec"
                                header="_pk|_tco_stitem_pk|_tco_spec_pk|Spec ID|Spec Name|Spec Group |Client"
                                format="0|0|0|0|0|0|0"
                                aligns="0|0|0|0|0|0|0"
                                defaults="|||||||"
                                editcol="1|1|1|0|0|0|0"
                                widths="0|0|0|2000|2500|2500|2500"
                                styles="width:100%; height:400"
                                sorting="T"
                                param="0,1,2"  />
                           </td>
                    </table>
            </td>
       </tr>
    </table>
   <gw:textbox id="txtStItem_PK" styles='width:100%;display:none;'   /> 
   <gw:textbox id="txtStItem_Group_PK" styles='width:100%;display:none;'   /> 
   <gw:textbox id="txtAuto_PK" styles='width:100%;display:none;'   /> 
   <gw:textbox id="txtSpecGroupList" styles='width:100%;display:none;'   />
</body>
</html>
