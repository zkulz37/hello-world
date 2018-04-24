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
    System.Translate(document);
   	iduser_pk.text = "<%=session("USER_PK")%>";
   	txtCompany_pk.text = "<%=session("COMPANY_PK")%>";
   	txtEvaNo.text="<%=request("eva_no")%>"    
  	var ls_data;
	ls_data="<%=ESysLib.SetListDataSQL("select code,code_nm ||' - ' ||code_fnm from vhr_hr_code where id='HR0008' ")%>";
    lstPosition.SetDataText(ls_data + "|ALL|ALL");
    lstPosition.SetDataText('ALL');
  	
  	
}
function OnCloseClick()
{
   
	var obj=new Array();
    obj[0]=0;
    obj[1]=0;
	window.returnValue = obj; 
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
            btnSelectALL.SetEnable(false);
            btnUselectALL.SetEnable(true);
            for (i = 1; i< grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i, 0, -1);
            }
         
        break;
        case 3://Unselect ALL
            txtchk.SetDataText("0");
            btnUselectALL.SetEnable(false);
            btnSelectALL.SetEnable(true);
            for (i = 1; i< grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i, 0, 0);
            }
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
   
           if(IsSelectItem=='1')
           {    
               var arrTemp=new Array();
                     
                 for(var j=0;j<grdDetail.cols;j++)
                 {
                    arrTemp[arrTemp.length]= grdDetail.GetGridData(grdDetail.row,j);
                 }
                 
                 arr_data[arr_data.length]= arrTemp;        
           }
           else
           {
            if(grdDetail.rows > 1)
               {   
                  for(var i=1;i<grdDetail.rows;i++)
                  {
                     var arrTemp=new Array();
                     alert(grdDetail.GetGridData(i,2));
                     if (grdDetail.GetGridData(i,2)== '-1')
                     {
                         for(var j=0;j<grdDetail.cols;j++)
                         {
                            arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
                         }             
                        arr_data[arr_data.length]= arrTemp;
                     }   
                  }
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
            datchem00050_21.Call('SELECT');
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
            var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
            //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
            var obj=System.OpenModal( fpath , 400 ,400, 'resizable:yes;status:yes'); //window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
           if (obj!=null)
            {
              
              txtOrganization_pk.text=obj;
              datchem00050_2.Call();
           }
        break;
        case 1:// Emp
            var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx";
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
         case 4:// upper department
          var fpath = System.RootURL + "/form/ch/em/chem00050_3.aspx" ;
          var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	        if (obj!=null)
            {
              txtPosition.text=obj[1] + ' - ' + obj[2];
              
            }
        break;
    }
}
//-------------------------------------------------------------
function onGridClick()
{
    lblname.text= grdDetail.GetGridData(grdDetail.row,4) + ' - ' + grdDetail.GetGridData(grdDetail.row,5);
    lbldept.text= grdDetail.GetGridData(grdDetail.row,3);
    lblLine.text= grdDetail.GetGridData(grdDetail.row,4)
    lblposition.text= grdDetail.GetGridData(grdDetail.row,6);
    var tmp =grdDetail.GetGridData(grdDetail.row,19);
   
    imgFile.SetDataText(tmp);
}
//-------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "datchem00050_1":
            datchem00050_3.Call('SELECT');
        break;
    }
}

</script>

<body bgcolor='#F5F8FF'>
 <!------------------------------------------>
<gw:data id="datchem00050_21" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,12,13,14,15,16,17,18" function="sp_sel_chem00050_21" procedure="sp_upd_thr_eva_emp"> 
                <input bind="grdDetail" >
                    <input bind="txtOrganization_pk" />
                    <input bind="txtEMP_pk" /> 
                    <input bind="lstPosition" />
                    <input bind="txtEvaNo" />
                    
                   </input>
                <output  bind="grdDetail" />
          
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
 <table border="1" cellspacing="1" width="100%">
  <tr valign=top>
    <td width="60%">
      <table border=0 cellpadding=0 cellspacing=1 width=100%>
        <tr valign=top>
            <td colspan=5 width=100%> 
                <fieldset style="padding: 2">
                    <table border="0" cellspacing="1" cellpadding=1 width="100%">
                   
                    
                    <tr>
                      <td width="20%"><a title="Click here to show Organization" onclick="OnShowPopup(0)" href="#tips" >Organization</a></td>
                      <td width="20%"><gw:textbox id="txtOrganization_ID" lang="1" onchange=""/><gw:textbox id="txtOrganization_pk" styles="display:none"/></td>
                      <td width="60%" colspan=2><gw:textbox id="txtOrganization_NM" lang="1" onchange=""/></td>
                    
                    </tr>
                     <tr>
                      <td width="20%">Position</td>
                      <td width="80%" colspan=3><gw:list id="lstPosition"  onchange=""/></td>
                    
                    </tr>
                   
                     <tr>
                      <td width="20%"><a title="Click here to show employee" onclick="OnShowPopup(1)" href="#tips" >
                    EMP ID/ NAME</a></td>
                      <td width="20%"><gw:textbox id="txtEMP_ID"  onenterkey="button_click(7)" onchange=""/><gw:textbox id="txtEMP_pk" styles="display:none"/></td>
                      <td width="55%"><gw:textbox id="txtEMP_NM" onenterkey="button_click(7)" onchange=""/></td>
                      <td width="5%"><gw:icon id="btnSearch" img="in" text="Search" onclick="button_click(7)" styles="width:100%" /></td>
                    </tr>
                  </table>
              </fieldset>
            </td>
         </tr>
         <tr height=400>
             <td width="100%" colspan="2" height="100"></td>

         </tr>
          <tr valign=bottom>
             <td width="5%"><gw:icon id="btnSave" img="in" text="Save" onclick="" styles="width:100%" /></td>
             <td width="5%"><gw:icon id="btnSaveEva" img="in" text="Save & Evaluation Group Entry" onclick="" styles="width:100%" /></td>
             <td width="5%"><gw:icon id="btnClose" img="in" text="Close" onclick="OnCloseClick()" styles="width:100%" /></td>
         </tr>
   </table>      
    </td>
    <td width="40%">
    <table border="0" cellspacing="1" width="100%">
      <tr>
        <td width="100%" colspan=2>EMPLOYEE INFO</td>
      </tr>
      <tr>
        <td width="50%">
            <table width="100%" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
				<tr>
					<td width=8%><gw:label id="lblname" text="EMP ID NAME" styles="width:100%; text-align:left" /></td>
				</tr>
			</table></td>
        <td width="50%" rowspan=4><gw:image id="imgFile"  oid="0" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:180;height:120" /></td>
      </tr>
      <tr>
        <td width="50%">
            <table width="100%" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
			    <tr>
				    <td width=8%><gw:label id="lbldept" text="DEPARTMENT" styles="width:100%; text-align:left" /></td>
			    </tr>
		    </table>
		</td>
    
      </tr>
       <tr>
        <td width="50%">
            <table width="100%" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
			    <tr>
				    <td width=8%><gw:label id="lblLine" text="Line" styles="width:100%; text-align:left" /></td>
			    </tr>
		    </table>
		</td>
    
      </tr>
       <tr>
        <td width="50%">
            <table width="100%" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
			    <tr>
				    <td width=8%><gw:label id="lblposition" text="POSITION" styles="width:100%; text-align:left" /></td>
			    </tr>
		    </table>
		</td>
    
      </tr>
      <tr>
      </tr>
        <td width=100% colspan=2>
            <gw:grid id="grdDebit" 
            header="Organization|Work period|Manager"
            format="0|0|0" 
            aligns="1|1|1"
            defaults="||" 
            editcol="1|1|1" 
            widths="2000|1500|2000"
            styles="width:100%; height:100" sorting="F" 
            oncelldblclick="" 
            oncellclick=""
            onafteredit=""
            onselchange="" />
        </td>
    </table>
    </td>
  </tr>
  <tr>
     <!--0_pk|1_pk_master|2.Select|3.Organization|4.EMP ID|5.EMP Name|6.Position|7.Evaluation Group| 8.1st Reviewer|9.|10.2nd Reviewer|11|12_THR_EVA_GROUP_PK|13.THR_EMP_PK|14.TCO_DEPT_PK|15.manager_pk1|16.manager_pk2|17. position_id|18. Status|19.Photo_pk-->
    <td width="100%" colspan="2">
         <gw:grid id="grdDetail" 
            header="_pk|_pk_master|_Select|Organization|EMP ID|EMP Name|Position|Evaluation Group| 1st Reviewer|Grade1|2nd Reviewer|Grade2|_THR_EVA_GROUP_PK|_THR_EMP_PK|_TCO_DEPT_PK|_manager_pk1|_manager_pk2|_position_id|_Status|_photo_pk"
            format="0|0|3|0|0|0|0|0| 0|0|0|0|0|0|0|0|0|0" 
            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
            defaults="|||||||||||||||||" 
            editcol="1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|1|1" 
            widths="0|0|700|2000|1500|2000|1500|2000| 1500|1000|1500|1000|0|0|0|0|0|0"
            styles="width:100%; height:320" sorting="F" 
            oncelldblclick="OnShowPopup(4)" 
            oncellclick="onGridClick()"
            onafteredit=""
            onselchange="onGridClick()" />
    </td>
  </tr>
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtEvaNo" styles="display:none"/>

<gw:textbox id="txtCompany_pk" styles="display:none"/>
<gw:list id="lstCompany" styles="display:none"/>
<gw:textbox id="txtchk"        text="0"         style="display:none" />


</body>
