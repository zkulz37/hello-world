<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
var flag='';
function BodyInit()
{
     
    var ls_data;
	System.Translate(document);
	txtEMP_NM.SetEnable(false);
	 //btnCancel.SetEnable(false);
    txtchk.SetDataText("0");
    txtCompany_pk.text = "<%=session("COMPANY_PK")%>";
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0")%>";
    lstEvaluationGrp.SetDataText(ls_data+ "|0|Select ALL");
    lstEvaluationGrp1.SetDataText(ls_data);
    lstEvaluationGrp.SetDataText("0");
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and CLOSE_YN='N' order by  EVA_YYYY ||' - ' || EVA_SEQ desc")%>";
    lstYear.SetDataText(ls_data);
    ls_data ="<%=ESysLib.SetGridColumnDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0" ) %>  ";
    grdDetail.SetComboFormat(7, ls_data);
    <%=ESysLib.SetGridColumnComboFormat("grdDetail" , 9, "SELECT 'Y', 'Y' FROM dual union SELECT 'N', 'N' FROM dual")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdDetail" , 11, "SELECT 'Y', 'Y' FROM dual union SELECT 'N', 'N' FROM dual")%>;
    ls_data ="<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0102' order by code_nm" ) %>  ";
    lstStatus.SetDataText(ls_data);
    lstStatus.SetDataText(ls_data+ "|%|ALL");
    lstStatus.SetDataText("%");

    ls_data = "DATA|1|Reviewer 1st|2|Reviewer 2nd";
    lstReviewer.SetDataText(ls_data);
    txtReviewer.SetEnable(0);

    datchem00050_1.Call();
}
//--------------------------------------------------------------------------------------------
function button_click(index){
    switch(index)
    {
        case 0://NEW EMPLOYEE for Evaluation Group
             var fpath   = System.RootURL + "/form/ch/em/chem00050_1.aspx?eva_no=" + lstYear.GetData();
             oValue      = System.OpenModal(  fpath , 1000 , 700 , 'resizable:yes;status:yes');
              if (oValue != null)
                {  
                  
                    grdDetail.SetData("");
                    for ( var i=0; i<oValue.length;i++)
                    {               
                        var aValue=oValue[i];
	                    aValue = oValue[i];  
                        grdDetail.AddRow();
                        grdDetail.SetGridText(grdDetail.rows-1, 4, aValue[2]); // 4.EMP ID
                        grdDetail.SetGridText(grdDetail.rows-1, 5    ,aValue[3]); //5.EMP Name
                        grdDetail.SetGridText(grdDetail.rows-1,6    ,aValue[4]); //6.Position
                        grdDetail.SetGridText(grdDetail.rows-1,13    ,aValue[1]); //13.THR_EMP_PK
                        grdDetail.SetGridText(grdDetail.rows-1,13    ,aValue[1]); //13.THR_EMP_PK 
                        grdDetail.SetGridText(grdDetail.rows-1,14    ,aValue[5]); // 5.TCO_DEPT_PK
                        grdDetail.SetGridText(grdDetail.rows-1,3    ,aValue[6]); //3.6dept_nm
                        grdDetail.SetGridText(grdDetail.rows-1,1    ,lstYear.GetData()); //3.6dept_nm
                        grdDetail.SetGridText(grdDetail.rows-1,15    ,aValue[7]); //7.manager_pk1
                        grdDetail.SetGridText(grdDetail.rows-1,8    ,aValue[8]); //manager_nm1
                        grdDetail.SetGridText(grdDetail.rows-1,16    ,aValue[9]);//manager_pk2
                        grdDetail.SetGridText(grdDetail.rows-1,10    ,aValue[10]);//manager_nm2
                        if(grdDetail.GetGridData(grdDetail.rows-1,15)=="")
                        {
                           
                            grdDetail.SetGridText(grdDetail.rows-1,9    ,'Y');//11 grade1
                        }  
                        
                        if(grdDetail.GetGridData(grdDetail.rows-1,16)=="")
                        {
                           
                             grdDetail.SetGridText(grdDetail.rows-1,11    ,'Y');//11 12grade2
                        }     
                       
                        grdDetail.SetGridText(grdDetail.rows-1,17    ,aValue[13]);//position id
                        grdDetail.SetGridText(grdDetail.rows-1,19    ,lblGradeEvatype.GetData());//position id
                        btnConfirm.SetEnable(false);
                        btnSelect.SetEnable(false);
                        btnUnselect.SetEnable(false);
                        btnDelete.SetEnable(false);
                        btnSetall.SetEnable(true);
                        btnSave.SetEnable(true);
                    }
                }
        break;
        case 1://Change Evaluator
             var fpath   = System.RootURL + "/form/ch/em/chem00050_2.aspx?eva_no=" + lstYear.GetData();
             aValue      = System.OpenModal(  fpath , 1000 , 700 , 'resizable:yes;status:yes');
        break;
        case 2://Select ALL
        
            if(Number(lstStatus.GetData())> 10)
            {
                for (i = 1; i< grdDetail.rows; i++)
                {
                   grdDetail.SetGridText(i, 2, -1);
                }
            }
            else
            {
                txtchk.SetDataText("1");
            
                for (i = 1; i< grdDetail.rows; i++)
                {
                    if(grdDetail.GetGridData(i,18)!= "SAVED")
                    {
                        grdDetail.row=-1;
                    }
                    else
                    {
                        if(grdDetail.GetGridData(i,0)=='')
                        {
                            alert('You should save item first.');
                            return false;
                        }
                        else
                            grdDetail.SetGridText(i, 2, -1);
                    }
                }
            }
           
         
        break;
        case 3://Unselect ALL
            txtchk.SetDataText("0");
           // btnUnselect.SetEnable(false);
          //  btnSelect.SetEnable(true);
            for (i = 1; i< grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i, 2, 0);
            }
        break;
        case 4://Set ALL
            for (i = 1; i< grdDetail.rows; i++)
            {
                if(grdDetail.GetGridData(i,18) == 'SAVED' || grdDetail.GetGridData(i,18) == ''){
                grdDetail.SetGridText(i, 12, lstEvaluationGrp1.GetData());
                grdDetail.SetGridText(i, 7, lstEvaluationGrp1.GetData());
                lstEvaluationGrp.SetDataText(lstEvaluationGrp1.GetData());
                }
            }
        break;
        case 5://Save
        
            for (i = 1; i < grdDetail.rows; i++)
            {
                if(grdDetail.GetGridData(i,0) == '' && grdDetail.GetGridData(i,12) == ''){
                    alert('You must set group first');
                    return;
                }else if(grdDetail.GetGridData(i,0) == '' && grdDetail.GetGridData(i,12) != '' && grdDetail.GetGridData(i,18) == 'SAVED' ){
                    grdDetail.SetRowStatus(i, 0x20);
                 }
            }     
             flag='save'  ;   
            datchem00050_3.Call("");
        break;
        case 6://Confirm
            var l_cnt=0;
            var l_save='';
            for (i = 1; i < grdDetail.rows; i++)
            {
                if(grdDetail.GetGridData(i,2) == '-1' )
                {
                     l_cnt =Number(l_cnt) + 1;
                }
              
            } 
           
            if(Number(l_cnt) == 0 )
            {
                alert('You should select item to confirm');
                return false;
            }else
            {
                if(confirm('Do you want to confirm selected item?'))
                {
                    for (i = 1; i < grdDetail.rows; i++)
                    {
                        //alert(grdDetail.GetGridData(i,0));
                        if(grdDetail.GetGridData(i,2) == '-1' &&  grdDetail.GetGridData(i,0)!= '' )
                        {
                             grdDetail.SetGridText(i, 18, 'CONFIRM');
                        }
                      
                    } 
                    flag='CONFIRM'  ;
                    datchem00050_3.Call(); 
                }
            }  
        break;
        case 7://Search
            
            if(Number(lstStatus.GetData())> 10)
            {
                btnCancel.SetEnable(true);
                btnSetall.SetEnable(false);
                btnSave.SetEnable(false);
                btnConfirm.SetEnable(false);
                btnDelete.SetEnable(false);
              
            }else
            {
                //btnCancel.SetEnable(false);
                btnSetall.SetEnable(true);
                btnSave.SetEnable(true);
                btnConfirm.SetEnable(true);
                btnDelete.SetEnable(true);
            }
            datchem00050_3.Call('SELECT');
        break;
        case 8://Delete
            var ctrl 	= grdDetail.GetGridControl();
            var l_cnt=0;
            for (i = 1; i < grdDetail.rows; i++)
            {
                if(grdDetail.GetGridData(i,2) == '-1' )
                {
                     l_cnt =Number(l_cnt) + 1;
                }
              
            } 
           
            if(Number(l_cnt) == 0 )
            {
                alert('You should select item to delete');
                return false;
            }
            else
            {   if(confirm('Do you want to delete selected item?'))
                {
                    for(i=1; i<grdDetail.rows; i++)
			        {
				        if (grdDetail.GetGridData(i,2) == '-1' && grdDetail.GetGridData(i, 18) == 'SAVED')
                        {
                            grdDetail.SetRowStatus(i,0x40);
				            //grdDetail.DeleteRow();
				            
				        }
			        }
			       flag='delete'  ;   
                   datchem00050_3.Call();     
                }    
            }  
        break;
        case 9: // print report
             var url = '/reports/ch/em/rptchem00050_1.aspx?eva_no=' + lstYear.GetText() + '&GradeType=' + lblGradeEvatype.GetData();
             url=url + '&Position=' + txtPosition.GetData() + '&period=' + lblPeriod.GetData() + '&schedule=' + lblSchedule.GetData();
             url = url + '&group=' + escape(lstEvaluationGrp.GetText()) + '&Org1=' + escape(txtOrganization_NM.GetData());
             url = url + '&grdtimes=' + escape(lblGradeEvatimes.GetData()) + '&p_year=' + lstYear.GetData()  ;
             url = url + '&p_organization_pk=' + txtOrganization_pk.GetData() + '&p_emp_pk=' + txtEMP_pk.GetData();
             url = url + '&p_position_id=' + txtPosition_id.GetData() + '&p_thr_eva_group_pk=' + lstEvaluationGrp.GetData()
             url = url + '&p_company_pk=' + txtCompany_pk.GetData() + '&status=' + lstStatus.GetData();
             //alert(url);
              System.OpenTargetPage( System.RootURL+url , "newform" );
        break;
        case 10:// cancel
            var l_cnt=0;
            var l_save='';
            for (i = 1; i < grdDetail.rows; i++)
            {
                if(grdDetail.GetGridData(i,2) == '-1' )
                {
                     l_cnt =Number(l_cnt) + 1;
                }
              
            } 
           
            if(Number(l_cnt) == 0 )
            {
                alert('You should select item to cancel');
                return false;
            }else
            {
                if(confirm('Do you want to cancel selected item?'))
                {
                    for (i = 1; i < grdDetail.rows; i++)
                    {
                        //alert(grdDetail.GetGridData(i,0));
                        if(grdDetail.GetGridData(i,2) == '-1' &&  grdDetail.GetGridData(i,0)!= '' )
                        {
                             grdDetail.SetGridText(i, 18, 'CANCEL');
                        }
                      
                    } 
                    flag='CANCEL'  ;
                    datchem00050_3.Call(); 
                }
            }  
        break;
        
    }
}
//--------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "datchem00050_1":
           // ChangeColor();
           //  alert(flag);
            flag = '';
            datchem00050_3.Call('SELECT');
        break;
        case "datchem00050_3":
            ChangeColor();
            if(Number(lstStatus.GetData()) > 10)
            {
                 btnConfirm.SetEnable(false);
                 btnSelect.SetEnable(true);
                 btnUnselect.SetEnable(true);
                 btnDelete.SetEnable(false);
                 btnSetall.SetEnable(false);
             }else
             {
                 btnConfirm.SetEnable(true);
                 btnSelect.SetEnable(true);
                 btnUnselect.SetEnable(true);
                 btnDelete.SetEnable(true);
                 btnSetall.SetEnable(true);
             }
                 
             lblTotalRecords.text = grdDetail.rows - 1 + ' staff(s)';
             if( flag=='CONFIRM')datchem00050_1.Call();
        break;
    }
}
//--------------------------------------------------------------------------------
function OnShowPopup(index)
{
    switch(index)
    {
        case 0:
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
              txtPosition_id.text=obj[1];
            }
        break;
        case 3:// position
       
            if(event.col==8)
            {
                
              var fpath = System.RootURL + "/form/ch/em/chem00050_3.aspx" ;
              var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	            if (obj!=null)
                {
                    var manager2_pk;
                    manager2_pk=grdDetail.GetGridData(grdDetail.row,16);
                    
                     grdDetail.SetGridText(grdDetail.row, 8, obj[2]); // 8.1st Reviewer name
                     grdDetail.SetGridText(grdDetail.row, 15, obj[0]); // 15.manager_pk1
               }
             }   
            if(event.col==10)
            {
                
              var fpath = System.RootURL + "/form/ch/em/chem00050_3.aspx" ;
              var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	            if (obj!=null)
                {
                    var manager1_pk;
                    manager1_pk=grdDetail.GetGridData(grdDetail.row,15);
                    
                     grdDetail.SetGridText(grdDetail.row, 10, obj[2]); // 10.2nd Reviewer
                     grdDetail.SetGridText(grdDetail.row, 16, obj[0]); // 16.manager_pk2
                   
                }
             }  
        break;
    }
}
function ChangeColor()
{
    var ctrl = grdDetail.GetGridControl();
    for (i = 1; i < ctrl.Rows; i++)
	{
	    if(grdDetail.GetGridData(i,18)!= "SAVED")
        {
	        //ctrl.Cell(0, i, 1, i, 18) = false;
	       // grdDetail.SetCellBold(i, 1, i, 18, true);
	       grdDetail.SetCellBgColor(i, 0, i, 18, 0X7AA0FF);
        }
        else
	    {
	        //ctrl.Cell(0, i, 1, i, 18) = false;
	      // grdDetail.SetCellBold(i, 1, i, 18, false);
	        grdDetail.SetCellBgColor(i, 0, i, 18, 0XFFFFFF);
	    }
	 
	}
}
//---------------------------------------------------------------------------------
function CellClick()
{
    var ctrl = grdDetail.GetGridControl();
    if(Number(lstStatus.GetData()) <= 10 )
    {
        for (i = 1; i < ctrl.Rows; i++)
	    {
	        if(grdDetail.GetGridData(grdDetail.row,18)!= "SAVED")
            {
                grdDetail.row=-1;
                return false;
            }
        }   
    }    
}
function OnRemoveReviewer(){
    if(grdDetail.row > 0){
        if(grdDetail.GetGridData(grdDetail.row,18) == "20"){
           alert("This data was confirmed. So you can not change.");
           return;
        }
        if(grdDetail.col == 10){
            if(confirm("Do you want to remove reviewer "+grdDetail.GetGridData(grdDetail.row,10)+" ?")){
                grdDetail.SetGridText(grdDetail.row,10,"");
                grdDetail.SetGridText(grdDetail.row,11,"");
                grdDetail.SetGridText(grdDetail.row,16,"");
                button_click(5);
            }
        }
        else{
            alert("Please click on the reviewer who you want to remove.");
        }
    }
    else{
        alert("Please click on the reviewer who you want to remove.");
    }
}

function OnSel_Reviewer()
{
    var fpath = System.RootURL + "/form/ch/em/chem00050_3.aspx" ;
              var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	            if (obj!=null)
                {
                    
                    txtReviewer_pk.text=obj[0];
                    txtReviewer.text=obj[2];
               }    
}

function onSet_Reviewer()
{
    var i;
    if(txtReviewer_pk.text=="")
    {
        alert("Please select reviewer before set.")
        return;
    }

    for (i = 1; i< grdDetail.rows; i++)
        {
            if(grdDetail.GetGridData(i,18) == 'SAVED' || grdDetail.GetGridData(i,18) == '')
            {
                if(lstReviewer.value=='1')//first reviewer
                {
                    grdDetail.SetGridText(i, 8, txtReviewer.text); // 8.1st Reviewer name
                    grdDetail.SetGridText(i, 15, txtReviewer_pk.text); // 15.manager_pk1
                }
                else
                {
                    grdDetail.SetGridText(i, 10, txtReviewer.text); // 8.1st Reviewer name
                    grdDetail.SetGridText(i, 16, txtReviewer_pk.text); // 15.manager_pk1
                }
            }
        }
}
//---------------------------------------------------------------------------------
</script>

<body bgcolor='#F5F8FF'>
   <!--------------------------------------->
<gw:data id="datchem00050_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00050_1" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_pk" />
                </input> 
                <output>
                    <output bind="lblPeriod" />
                    <output bind="lblSchedule" />
                    <output bind="lblGradeEvatype" />
                    <output bind="lblGradeEvatimes" />
                    <output bind="lblTotal" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datchem00050_3" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,7,9,11,13,14,15,16,17,18,19" function="HR_sel_chem00050_3" procedure="HR_upd_chem00050_3"> 
                <input bind="grdDetail" >
                    <input bind="lstYear" />
                    <input bind="txtOrganization_pk" />
                    <input bind="txtEMP_ID" /> 
                    <input bind="txtPosition_id" />
                    <input bind="lstEvaluationGrp" />
                    <input bind="txtCompany_pk" />
                    <input bind="lstStatus" />
                    
                   </input>
                <output  bind="grdDetail" />
          
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
  <table border="0" cellspacing="1" cellpadding=1 width="100%">
      <tr>
        <td width="100%" colspan=50>
            <fieldset style="padding: 2">
              <table border="0" cellspacing="1" cellpadding=1 width="100%">
                  <tr>
                    <td colspan=5 width="10%">Evaluation #</td>
                    <td width="10%" colspan=5> <gw:list id="lstYear" styles="width:100%"   onchange="datchem00050_1.Call()"/></td>
                    <td colspan=6 width="12%" align=right>Evaluation Period</td>
                    <td width="1%">&nbsp;</td>
                    <td width="12%" colspan=6><gw:label id="lblPeriod" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" /></td>
                    <td colspan=5 width="10%">Eva. times</td>
                    <td colspan=5 width="10%"><gw:label id="lblGradeEvatype" text="" styles="width:100%; text-align:left; border:1px solid #6B9EB8" /></td>
                    <td width="10%" align=right>Schedule</td>
                    <td width="1%">&nbsp;</td>
                    <td colspan=6 width="12%" ><gw:label id="lblSchedule" text="" styles="width:100%; text-align:center;border:1px solid #6B9EB8" /></td>
                  </tr>
             </table>
            </fieldset> 
       </td>
      </tr>
   
      <tr>
        <td width="100%" colspan=50 ><fieldset style="padding: 2">
          <table border="0" cellspacing="0" cellpadding=0 width="100%">
              <tr>
                <td colspan=5 width="10%"><a title="Click here to show Organization" onclick="OnShowPopup(0)" href="#tips" >
                            Organization</a></td>
                <td colspan=3 width="6%"><gw:textbox id="txtOrganization_ID" lang="1" onchange=""/></td>
                <td colspan=10 width="20%"><gw:textbox id="txtOrganization_NM" lang="1" onchange=""/></td>
                <td colspan=2 width="4%"><gw:imgBtn id="ibtMovAccReset" img="reset"  alt="Reset" onclick="txtOrganization_ID.text='';txtOrganization_pk.text='';txtOrganization_NM.text='';" /></td>
                <td colspan=5 width="10%"><a title="Click here to show Position" onclick="OnShowPopup(2)" href="#tips" >Position</a></td>
                <td colspan=10 width="10%"><gw:textbox id="txtPosition"  onchange=""/></td>
                <td colspan=2 width="4%"><gw:imgBtn id="ibtMovAccReset" img="reset"  alt="Reset" onclick="txtPosition.text='';txtPosition_id.text='';" /></td>
                <td colspan=2 width="4%" align=right><a title="Click here to show employee" onclick="OnShowPopup(1)" href="#tips" >EMP</a></td>
                <td colspan=3 width="6%"><gw:textbox id="txtEMP_ID" lang="1" onenterkey="button_click(7)"/></td>
                <td colspan=7 width="14%"><gw:textbox id="txtEMP_NM" lang="1" onchange=""/></td>
                <td colspan=1 width="2%"><gw:imgBtn id="ibtMovAccReset" img="reset"  alt="Reset" onclick="txtEMP_ID.text='';txtEMP_NM.text='';txtEMP_pk.text='';" /></td>
              </tr>
              <tr>
                <td colspan=5 width="10%" align=right>Eva Emp Status</td>
                <td colspan=5><gw:list id="lstStatus"  onchange="button_click(7)"/></td>
                 <td colspan=5 align=right>Evaluation Group</td>
                <td colspan=5><gw:list id="lstEvaluationGrp"  onchange="button_click(7)"/></td>
                <td colspan=18><gw:label id="lblTotal"  onchange=""/></td>
                <td colspan=5> <gw:label id="lblTotalRecords"  styles="width:100%;color:red; font-weight:500;" /></td>
                <td colspan=3> <gw:icon id="btnNewEMP" img="in" text="Select Employee" onclick="button_click(0)" styles="width:100%" /></td>
                <td colspan=2> <gw:icon id="btnSearch" img="in" text="Search" onclick="button_click(7)" styles="width:100%" /></td>
                <td colspan=2> <gw:icon id="btnPrint" img="in" text="Print" onclick="button_click(9)" styles="width:100%" /></td>
              </tr>
         </table>
        </fieldset>
      </td>
     </tr>
    
     <tr>
        <td width="4%"> <gw:icon id="btnSelect" img="in" text="Select ALL" onclick="button_click(2)" styles="width:100%" /></td>
        <td width="4%"> <gw:icon id="btnUnselect" img="in" text="Unselect ALL" onclick="button_click(3)" styles="width:100%" /></td>
        <td width="10%" align=right><a title="Click here to select reviewer" onclick="OnSel_Reviewer()" href="#tips" >Reviewer</a></td>
        <td width="20%"><gw:textbox id="txtReviewer" onchange=""/></td>
        <td width="10%"><gw:list id="lstReviewer"  onchange=""/></td>
        <td width="4%"> <gw:icon id="btnSet" img="in" text="SetAll" onclick="onSet_Reviewer()" styles="width:100%" /></td>
        <td width="10%" align=right>Evaluation Group</td>
        <td width="10%"><gw:list id="lstEvaluationGrp1"  onchange=""/></td>
        <td width="4%"> <gw:icon id="btnSetall" img="in" text="Set All" onclick="button_click(4)" styles="width:100%" /></td>
        <td width="2%"> &nbsp;</td>
        <td width="4%"> <gw:icon id="btnSave" img="in" text="Save" onclick="button_click(5)" styles="width:100%" /></td>
        <td width="4%"> <gw:icon id="btnConfirm" img="in" text="Confirm" onclick="button_click(6)" styles="width:100%" /></td>  
        <td width="4%"> <gw:icon id="btnCancel" img="in" text="Cancel" onclick="button_click(10)" styles="width:100%" /></td>     
        <td width="4%"> <gw:icon id="btnDelete" img="in" text="Delete" onclick="button_click(8)" styles="width:100%" /></td>
     </tr>
      <tr>
        <!--0_pk|1_pk_master|2.Select|3.Organization|4.EMP ID|5.EMP Name|6.Position|7.Evaluation Group| 8.1st Reviewer|9.grade1|10.2nd Reviewer|11. grade2|12_THR_EVA_GROUP_PK|13.THR_EMP_PK|14.TCO_DEPT_PK|15.manager_pk1|16.manager_pk2|17. position_id|18. Status|19. Grade type-->
        <td width="100%" colspan=14>
            <gw:grid id="grdDetail" 
            header="_pk|_pk_master|Select|Organization|EMP ID|EMP Name|Position|Evaluation Group| 1st Reviewer|Eva. 1|2nd Reviewer|Eva. 2|_THR_EVA_GROUP_PK|_THR_EMP_PK|_TCO_DEPT_PK|_manager_pk1|_manager_pk2|_position_id|Eva Emp Status|_gradetype"
            format="0|0|3|0|0|0|2|0|0|0|0|0|0|0|0|0|0|0|0|0" 
            aligns="0|0|0|0|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0"
            defaults="|||||||||Y||Y||||||||" 
            editcol="1|1|1|1|1|1|0|0|0|1|0|1|0|0|0|0|1|0|0|0" 
            widths="0|0|700|2700|800|2000|1500|2000|1800|600|1800|600|0|0|0|0|0|0|0|0"
            styles="width:100%; height:520" sorting="T" 
            oncelldblclick="OnShowPopup(3)" 
            oncellclick="CellClick()"
            onafteredit=""
            onselchange="" />
        </td>
     </tr>
   <tr>
     <td >
        
    </td>
  </tr>
</table>
<gw:textbox id="txtchk"        text="0"         style="display:none" />
<gw:textbox id="txtCompany_pk" styles="display:none"/>
<gw:label id="lblGradeEvatimes" text="" styles="width:100%; text-align:left;border:1px solid #6B9EB8;display:none" />

<gw:textbox id="txtEMP_pk" styles="display:none"/>
<gw:textbox id="txtPosition_id"  styles="display:none"/>
<gw:textbox id="txtOrganization_pk" styles="display:none"/>
<gw:textbox id="txtReviewer_pk" styles="display:none"/>

</body>
