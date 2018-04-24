<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
var flag='';
var IsSelectItem ;
function BodyInit()
{
   	iduser_pk.text = "<%=session("USER_PK")%>";
   	txtCompany_pk.text = "<%=session("COMPANY_PK")%>";
   	txtEvaNo.text="<%=request("eva_no")%>"    
  	var ls_data;
	System.Translate(document);
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and CLOSE_YN='N'")%>";
    lstYear.SetDataText(ls_data);
    lstYear.SetDataText(txtEvaNo.GetData());
    ls_data="<%=ESysLib.SetListDataSQL("select code,code_nm ||' - ' ||code_fnm from vhr_hr_code where id='HR0008' ")%>";
   
    lstPosition.SetDataText(ls_data + "|ALL|Select ALL");
    lstPosition.SetDataText('ALL');
  	datDeptTree.Call("SELECT");
  	
}
function OnCloseClick()
{
   var obj=new Array();
    window.returnValue = null; 
	window.close();
}
//---------------------------------------------------------
function button_click(index){
    switch(index)
    {
        case 0://NEW EMPLOYEE for Evaluation Group
             var fpath   = System.RootURL + "/form/ch/em/chem00050_1.aspx";
             aValue      = System.OpenModal(  fpath , 1000 , 700 , 'resizable:yes;status:yes');
        break;
        case 1://Change Evaluator
             var fpath   = System.RootURL + "/form/ch/em/chem00050_2.aspx";
             aValue      = System.OpenModal(  fpath , 1000 , 700 , 'resizable:yes;status:yes');
        break;
        case 2://Select ALL
            txtchk.SetDataText("1");
           // btnSelectALL.SetEnable(false);
          //  btnUselectALL.SetEnable(true);
            var col_val ;
            for (i = 1; i< grdDetail.rows; i++)
            {
               // grdDetail.SetGridText(i, 0, -1);
                col_val = grdDetail.GetGridData(i,1);
                //alert(col_val);
                if( !CheckDataExist(grdDetail1,col_val))
                {
                    SetRowBackGroundColor(grdDetail,col_val,0x0000FF);
		            grdDetail1.AddRow();
		         
		            for(var j=0;j<grdDetail.cols;j++)
		            {
		               // alert('i =' + i + ', j=' + j);
		              grdDetail1.SetGridText(grdDetail1.rows-1,j,grdDetail.GetGridData(i,j));
		            }
                }
              
            }
            countItem();
        break;
        case 3://Unselect ALL
            txtchk.SetDataText("0");
           // btnUselectALL.SetEnable(false);
          //  btnSelectALL.SetEnable(true);
            for (i = 1; i< grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i, 0, 0);
            }
            OnRemoveAll();
        break;
        case 4://Set ALL
            for (i = 1; i< grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i, 12, lstEvaluationGrp.GetData());
                grdDetail.SetGridText(i, 7, lstEvaluationGrp.GetText());
            }
           
        break;
        case 5://Save
            
        break;
        case 6://Return
             var arr_data = new Array();
   
           if(grdDetail1.rows > 1)
           {   
              for(var i=1;i<grdDetail1.rows;i++)
              {
                 var arrTemp=new Array();
                //  alert(grdDetail.GetGridData(i,2));
                // if (grdDetail1.GetGridData(i,0)== '-1')
               //  {
                    for(var j=0;j<grdDetail1.cols;j++)
                     {
                        arrTemp[arrTemp.length]= grdDetail1.GetGridData(i,j);
                     }             
                     arr_data[arr_data.length]= arrTemp;
                // }    
              }
           }
        
                
          if ( arr_data !=null )
          {
	        window.returnValue =  arr_data;
	        window.close();
          }
          else
          {
            alert("You have not selected data yet.");
          }
        break;
        case 7://Search
            datchem00051_2.Call('SELECT');
        break;
        
    }
}
//---------------------------------------------------------
function OnShowPopup(index)
{
    switch(index)
    {
        case 0: // Organization
             var strcom;
            var fpath = System.RootURL + "/form/ch/em/chem00050_4.aspx?";
            //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
            var obj=System.OpenModal( fpath , 400 ,400, 'resizable:yes;status:yes'); //window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
           if (obj!=null)
            {
              
              txtOrganization_pk.text=obj;
              datchem00050_2.Call();
           }
        break;
        case 1:// Emp
            var fpath = System.RootURL + "/form/ch/em/chem00050_5.aspx";
	        var aValue = System.OpenModal( fpath , 900 ,600, 'resizable:yes;status:yes'); 
	        if ((aValue != null)&&(aValue[0]!=""))
	        {
	            txtEMP_pk.text = aValue[0];
	            txtEMP_ID.text = aValue[1];
	            txtEMP_NM.text = aValue[2];
	        }
	    break;
        case 2:// position
          var fpath = System.RootURL + "/form/ch/em/chem00050_com_code.aspx?code=HR0008" ;
          var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	        if (obj!=null)
            {
              txtPosition.text=obj[1] + ' - ' + obj[2];
              
            }
        break;
    }
}
//---------------------------------------------------------
function treeItemOnclick()
{
    var obj = event.srcElement.GetCurrentNode();
    flag='search';
    txtOrganization_pk.text=obj.oid;
    datchem00050_2.Call();
}
//---------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "datDeptTree":
            
            datchem00051_1.Call();
        break;
        case "datchem00051_1":
            lbl_total_emp1.text=lbl_total_emp.GetData();
        break;
        case "datchem00050_2":
            if(flag=='search')
            {
                button_click(7);
            }
        break;
    }
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
  if(oGrid.id == "grdDetail")
  {
    var col_val = oGrid.GetGridData(event.row,1);
    
    if(event.row > 0 && ( !CheckDataExist(grdDetail1,col_val)) )
    {
        SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		grdDetail1.AddRow();
		for(var i=0;i<oGrid.cols;i++)
		{
		  grdDetail1.SetGridText(grdDetail1.rows-1,i,oGrid.GetGridData(event.row,i));
		}
     }
  }
  countItem();
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,1) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
  for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,1) == p_value)
      {
         return true;
      }
   }
   return false;
}
//-------------------------------------------------------------------------------------------------
function OnRemoveAll()
{
   var col_val;
    for(var i=1;i<grdDetail1.rows;i++)
    {
        col_val = grdDetail1.GetGridData(i,1);
        
        SetRowBackGroundColor(grdDetail,col_val,0x000000); 
    }
    grdDetail1.SetData("");
    countItem();
}
//--------------------------------------------------------------------
function OnRemove()
{
  if(grdDetail1.row > 0)
  {
    var col_val = grdDetail1.GetGridData(grdDetail1.row,1);
    grdDetail1.RemoveRowAt(grdDetail1.row);
    SetRowBackGroundColor(grdDetail,col_val,0x000000); 
    countItem();
  }
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=grdDetail1.rows-1 + " staff(s)."
}
//---------------------------------------------------------
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="datDeptTree"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="tree" function="sp_sel_dept_tree1" > 
                <input>
                    <input bind="txtCompany_pk" /> 
                    <input bind="iduser_pk" /> 
                     <input bind="lstYear" /> 
                </input> 
                <output bind="treDept" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="datchem00051_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem00051_1" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_pk" />
                </input> 
                <output>
                    <output bind="lblPeriod" />
                    <output bind="lblSchedule" />
                    <output bind="lbl_total_emp" />
                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datchem00050_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_dept_data1" > 
                <input>
                    <input bind="txtOrganization_pk" /> 
                </input> 
                <output>
                    <output bind="txtOrganization_ID" />
                    <output bind="txtOrganization_NM" />
          </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datchem00051_2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,3,5,8,9,10,1" function="sp_pro_chem00051_2" procedure=""> 
                <input bind="grdDetail" >
                    <input bind="txtOrganization_pk" />
                    <input bind="lstPosition" />
                    <input bind="txtEMP_ID" /> 
                    <input bind="txtEMP_NM" />
                    <input bind="txtEvaNo" />
                    <input bind="txtCompany_pk" />
                   </input>
                <output  bind="grdDetail" />
            </dso> 
        </xml> 
</gw:data>
 <!-------------------------------------------------------------->
 <table border="0" cellspacing="1"  cellpadding=1 width="100%">
  <tr>
    <td width="100%"><fieldset style="padding: 2">
        <table border="0" cellspacing="1" cellpadding=1 width="100%">
          <tr>
            <td width="10%">Evaluation #</td>
            <td width="10%"> <gw:list id="lstYear" type="month" lang="1" onchange="datchem00051_1.Call()"/></td>
            <td width="15%" align=right>Evaluation Period</td>
            <td width="2%">	</td>
            <td width="20%"><gw:label id="lblPeriod" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" /></td>
          
            <td width="10%" align=right>Schedule</td>
            <td width="2%">&nbsp;</td>
            <td width="20%"><gw:label id="lblSchedule" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" /></td>
           
          </tr>
          <tr>
            <td colspan=8 align=center><gw:label id="lbl_total_emp" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" lang="1" onchange=""/></td>
         
          </tr>
       
        </table>
    </fieldset> </td>
  </tr>
  <tr>
    <td width="100%">
    <table border="1" cellspacing="1" width="100%">
        <tr valign=top>
        <td width="40%" >
            <table cellpadding=0 cellspacing=2 width=100% border=0>
                <tr>
                    <td> <gw:label id="lbl_total_emp1" styles="width:100%; text-align:left;border:1px solid #6B9EB8;font-weight:500;color:red"  /></td>
                </tr>
                 <tr>
                   
                </tr>
                <tr>
                    <td>
	                    <gw:tree  id="treDept" onclicknode="treeItemOnclick()" style="width:100%; height:100%;overflow:auto;"  >
		                </gw:tree>  
		           </td>
		       </tr>
            </table>
       </td>
        <td width="60%"> 
             <table border=0 cellpadding=0 cellspacing=1 width=100%>
                <tr>
                    <td colspan=5 width=100%> 
                        <fieldset style="padding: 2">
                            <table border="0" cellspacing="1" cellpadding=1 width="100%">
                            <tr>
                              <td width="20%"><a title="Click here to show Organization" onclick="OnShowPopup(0)" href="#tips" >
                            Organization</a></td>
                              <td width="20%"><gw:textbox id="txtOrganization_ID" lang="1" onchange=""/><gw:textbox id="txtOrganization_pk" styles="display:none"/></td>
                              <td width="60%" colspan=2><gw:textbox id="txtOrganization_NM" lang="1" onchange=""/></td>
                              <td><gw:imgBtn id="ibtMovAccReset" img="reset"  alt="Reset" onclick="txtOrganization_ID.text='';txtOrganization_pk.text='';txtOrganization_NM.text='';" /></td>
                            </tr>
                            <tr>
                              <td width="20%">Position</td>
                              <td width="80%" colspan=4><gw:list id="lstPosition"  onchange=""/></td>
                            
                            </tr>
                            <tr>
                              <td width="20%"><a title="Click here to show employee" onclick="OnShowPopup(1)" href="#tips" >
                            EMP ID/ NAME</a></td>
                              <td width="20%"><gw:textbox id="txtEMP_ID"  onenterkey="button_click(7)" onchange=""/><gw:textbox id="txtEMP_pk" styles="display:none"/></td>
                              <td width="55%" colspan=2><gw:textbox id="txtEMP_NM" onenterkey="button_click(7)" onchange=""/></td>
                              <td><gw:imgBtn id="ibtMovAccReset" img="reset"  alt="Reset" onclick="txtEMP_ID.text='';txtEMP_NM.text='';txtEMP_pk.text='';" /></td>
                             
                            </tr>
                          </table>
                      </fieldset>
                    </td>
                 </tr>
                 <tr>
                     <td width="5%"><gw:icon id="btnSelectALL" img="in" text="Select ALL" onclick="button_click(2)" styles="width:100%" /></td>
                     <td width="5%"><gw:icon id="btnUselectALL" img="in" text="Uselect ALL" onclick="button_click(3)" styles="width:100%" /></td>
                     <td width="5%"><gw:icon id="btnReturn" img="in" text="Evaluation Group Entry (Return)" onclick="button_click(6)" styles="width:100%" /></td>
                      <td width="5%"><gw:icon id="btnSearch" img="in" text="Search" onclick="button_click(7)" styles="width:100%" /></td>
                     <td width="5%"><gw:icon id="btnClose" img="in" text="Close" onclick="OnCloseClick()" styles="width:100%" /></td>
                 </tr>
                 <tr>
                    <!--0.Select|1_emp_pk|2.EMP ID|3.EMP Name|4.Position|5_TCO_DEPT_PK|6_dept_nm|7_manager_pk1|8_manager_nm1|9_manager_pk2|10_manager_nm2|11_grade1|_12grade2|13_position_id"-->
                    <td width=100% colspan=5>
                         <gw:grid id="grdDetail" 
                        header="_Select|_emp_pk|EMP ID|EMP Name|Position|_TCO_DEPT_PK|_dept_nm|_manager_pk1|_manager_nm1|_manager_pk2|_manager_nm2|_grade1|_grade2|_position_id"
                        format="3|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||" 
                        editcol="1|1|1|1|1|1|1|0|0|0|0|0|0|0" 
                        widths="700|0|2000|3500|2000|0|0|0|0|0|0|0|0|0"
                        styles="width:100%; height:230" sorting="T" 
                        oncelldblclick="OnGridCellDoubleClick(this)" 
                        oncellclick=""
                        onafteredit=""
                        onselchange="" />
                    </td>
                 </tr>
                  <tr>
                    <!--0.Select|1_emp_pk|2.EMP ID|3.EMP Name|4.Position|5_TCO_DEPT_PK|6_dept_nm|7_manager_pk1|8_manager_nm1|9_manager_pk2|10_manager_nm2|11_grade1|_12grade2|13_position_id"-->
                    <td width=100% colspan=4>
                       <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                    </td>
                     <td width=100% colspan=1>
                        <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                    </td>
                 </tr>
                
                 <tr>
                    <td width=100% colspan=5>
                         <gw:grid id="grdDetail1" 
                        header="_Select|_emp_pk|EMP ID|EMP Name|Position|_TCO_DEPT_PK|_dept_nm|_manager_pk1|_manager_nm1|_manager_pk2|_manager_nm2|_grade1|_grade2|_position_id"
                        format="3|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||" 
                        editcol="1|1|1|1|1|1|1|0|0|0|0|0|0|0" 
                        widths="700|0|2000|3500|2000|0|0|0|0|0|0|0|0|0"
                        styles="width:100%; height:220" sorting="T" 
                        oncelldblclick="" 
                        oncellclick=""
                        onafteredit=""
                        onselchange="" />
                    </td>
                 </tr>
              </table>        
        </td>
      </tr>
     
    </table>
    </td>
  </tr>
</table>
<gw:textbox id="txtEvaNo" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtCompany_pk" styles="display:none"/>
<gw:list id="lstCompany" styles="display:none"/>
<gw:textbox id="txtchk"        text="0"         style="display:none" />
</body>
