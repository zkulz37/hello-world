<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPOINTMENT EXECUTE</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var  company_pk   =  "<%=Session("COMPANY_PK")%>"  ;
var flag="";
var pk_list;
var rowclick;
var flag_WG = false;    
var c_pk =0,
    c_select =1,
    c_Emp_ID=2,
    c_Full_Name=3,
    c_From_Org=4,
    c_From_WG =5,
    c_From_Position=6,
    c_From_Education =7
    c_From_Manager=8,
    c_Old_Salary=9,
    c_To_Org=10,
    c_To_WG =11,
    c_To_Position=12,
    c_To_Education = 13
    c_To_Manager =14,
    c_New_Salary=15,
    c_App_Date=16,
    c_Approve_DT =17,
    c_Description=18,
    c_Times =19,
    c_THR_EMP_PK=20,
    c_FROM_ORG_PK = 21,
    c_FROM_POS_TYPE = 22,
    c_TO_ORG_PK = 23,
    c_FROM_MANAGER_ID=24,
    c_FROM_MANAGER_ORG_PK =25,
    c_FROM_MANAGER_POS_PK =26,
    c_From_WG_PK=27,
    c_From_Education = 28;
	c_appointment_type = 29;
//_PK|Select|Emp ID|Full Name|From Organization|From Workgroup|From Position|From Education|From Manager|Old Salary|
//To Organization|To Workgroup|To Position|To Education|To Manager|New Salary|App Date|Approve DT|Reason|Times|_THR_EMP_PK
//|_FROM_ORG_PK|_FROM_POS_PK|_TO_ORG_PK|_FROM_MANAGER_ID|_FROM_MANAGER_ORG_PK|_FROM_MANAGER_POS_PK|_FROM_WG_PK|_FROM_EDUCATION_PK|Appointment Type
	var o_pk =0;
    o_select =1;
    o_emp_id = 2;
    o_fullname =3;
    o_from_org =4;
    o_from_wg =5;
    o_from_position =6;
    o_from_education =7;
    o_from_manager =8;
    o_Old_Salary = 9;
    o_to_org =10;
    o_to_wg = 11;
    o_to_position = 12;
    o_to_education = 13;
    o_to_manager = 14;
    o_New_Salary = 15;
    o_app_date = 16;
    o_approve_dt =17;
    o_description =18;
    o_times = 19;
	o_appointment_type = 20;
//_PK|Select|Emp ID|Full Name|From Organization|From Workgroup|From Position|From Education|From Manager|Old Salary|To Organization|
//To Workgroup|To Position|To Education|To Manager|New Salary|App Date|Approve Date|Description|Times|Appointment Type	
function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    var  t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
       grdApp.SetComboFormat(c_To_Position,t1); //position
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0011' order by code_nm")%>";
       grdApp.SetComboFormat(c_To_Education,t1); //education
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select w.pk,w.workgroup_nm from thr_work_group w where w.del_if=0" )%>";
       grdApp.SetComboFormat(c_To_WG,t1); //wg
	   t1 = "<%=ESysLib.SetGridColumnDataSQL("select '0' as app_codetype ,'Promotion' as app_type from dual union select '1' as app_codetype ,'Movement' as app_type from dual union select '2' as app_codetype ,'Movement & Promotion' as app_type from dual union select '99' as app_codetype ,' ' as app_type from dual " )%>";
       grdApp.SetComboFormat(c_appointment_type,t1); //appointment type	   	  
       txt_WG_temp1.text="<%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0 order by nvl(seq,9999)")%>";
       ChangeColorItem(lstOrg1.GetControl());

       datCheck_View.Call();
}
//---------------------------------------------------------------------  

 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

 //------------------------------------------------------------------------------------
function OnSave()
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
    {
            
            datAppointment.Call();
    }
}
//-------------------------------------------------------------------------------------
function OnSearch()
{
           //add wgroup to grid    
           var arr = txt_WG_temp1.text.replace("DATA|",'').split("|");
           var s="";
           var t=0;
	           for(var i=0;i< (arr.length+1)/2-1;i++)
	            {
		            s = s +"#" + arr[t] + ";" + arr[t+1]+"|";
		            t=t+2;
		        }
	       grdApp.SetComboFormat(o_to_wg,s  );
    datAppointment.Call("SELECT");
}
//--------------------------------------------------------------------------------------------------
function OnDelete()
{
    if(confirm("Delete it?\nBạn muốn xóa?"))
    {
        grdApp.DeleteRow();
    }
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datCheck_View":
        {
            if(txtFlag_View.text == 'Y')
            {
                btnAdd.style.display = "none";
                btnSave.style.display = "none";
                btnDelete.style.display = "none";
            }
        
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }   
	        else 
                datSal_security.Call();     
            
        }
        break;
        case "datAppointment":
        {   
            
            idRecord.text=grdApp.rows-1 + " Records.";
            if(grdApp.rows > 1)
            {
                auto_resize_column(grdApp,0,grdApp.cols-1,10);
                for(var i=1;i<grdApp.rows;i++)
                {
                    grdApp.SetCellBgColor(i, c_From_Org,i, c_Old_Salary, 0xCCFFFF);
                    grdApp.SetCellBgColor(i, c_To_Org,i, c_New_Salary, 0xFFEEFF);
                    if(grdApp.GetGridData(i, c_TO_ORG_PK)!= grdApp.GetGridData(i, c_FROM_ORG_PK))
                    {
                        grdApp.SetCellFontColor(i, c_To_Org,i, c_To_Org, 0x300FF3 );
                    }
                    if(grdApp.GetGridData(i, c_To_WG)!= grdApp.GetGridData(i, c_From_WG_PK))
                    { 
                        grdApp.SetCellFontColor(i, c_To_WG,i, c_To_WG, 0x300FF3 );
                    }
                    if(grdApp.GetGridData(i, c_To_Position)!= grdApp.GetGridData(i, c_FROM_POS_TYPE))
                    {
                        grdApp.SetCellFontColor(i, c_To_Position,i, c_To_Position, 0x300FF3 );
                    }
                    if(grdApp.GetGridData(i, c_To_Education)!= grdApp.GetGridData(i, c_From_Education))
                    {
                        grdApp.SetCellFontColor(i, c_To_Education,i, c_To_Education, 0x300FF3 );
                    }
                    if(grdApp.GetGridData(i, c_To_Manager)!= grdApp.GetGridData(i, c_From_Manager))
                    {
                        grdApp.SetCellFontColor(i, c_To_Manager,i, c_To_Manager, 0x300FF3 );
                    }
                    if(grdApp.GetGridData(i, c_New_Salary)!= grdApp.GetGridData(i, c_Old_Salary))
                    {
                        grdApp.SetCellFontColor(i, c_New_Salary,i, c_New_Salary, 0x300FF3 );
                    }
                }
            }
        }
        break;
        case "datApp_old":
        {
            if(grdApp_old.rows > 1)
            {
                auto_resize_column(grdApp_old,0,grdApp_old.cols-1,10);
                for(var i=1;i<grdApp_old.rows;i++)
                {
                    grdApp_old.SetCellBgColor(i, o_from_org,i, o_Old_Salary, 0xCCFFFF);
                    grdApp_old.SetCellBgColor(i, o_to_org,i, o_New_Salary, 0xFFEEFF);
                    if(grdApp_old.GetGridData(i, o_to_org)!= grdApp_old.GetGridData(i, o_from_org))
                    {
                        grdApp_old.SetCellFontColor(i, o_to_org,i, o_to_org, 0x300FF3 );
                    }
                    if(grdApp_old.GetGridData(i, o_to_wg)!= grdApp_old.GetGridData(i, o_from_wg))
                    {
                        grdApp_old.SetCellFontColor(i, o_to_wg,i, o_to_wg, 0x300FF3 );
                    }
                    if(grdApp_old.GetGridData(i, o_to_position)!= grdApp_old.GetGridData(i, o_from_position))
                    {
                        grdApp_old.SetCellFontColor(i, o_to_position,i, o_to_position, 0x300FF3 );
                    }
                    if(grdApp_old.GetGridData(i, o_to_education)!= grdApp_old.GetGridData(i, o_from_education))
                    {
                        grdApp_old.SetCellFontColor(i, o_to_education,i, o_to_education, 0x300FF3 );
                    }
                    if(grdApp_old.GetGridData(i, o_to_manager)!= grdApp_old.GetGridData(i, o_to_manager))
                    {
                        grdApp_old.SetCellFontColor(i, o_to_manager,i, o_to_manager, 0x300FF3 );
                    }
                    if(grdApp_old.GetGridData(i, o_New_Salary)!= grdApp_old.GetGridData(i, o_Old_Salary))
                    {
                        grdApp_old.SetCellFontColor(i, o_New_Salary,i, o_New_Salary, 0x300FF3 );
                    }
                }
            }
            break;
        }
        case "datGet_Org":
        {
            grdApp.SetGridText(rowclick,c_To_Org,txtOrgNM.text);
        }
        break;
        case "datUser_info":
        {
            lstOrg1.SetDataText(txtdept_temp.text + "|ALL|Select All");
			lstOrg1.value = "ALL";
            lstOrg2.SetDataText(txtdept_temp.text + "|ALL|Select All");
			lstOrg2.value = "ALL";

            ChangeColorItem(lstOrg1.GetControl());

            datSal_security.Call(); 
         }   
          break;
        case "datSal_security":
           if(txt_sal_security.text=='N') 
           {
                    grdApp.GetGridControl().ColHidden(c_Old_Salary)=1;
                    grdApp.GetGridControl().ColHidden(c_New_Salary)=1;
                    grdApp_old.GetGridControl().ColHidden(o_Old_Salary)=1;
                    grdApp_old.GetGridControl().ColHidden(o_New_Salary)=1;
                    
           }
           txtOrgPK.text=lstOrg1.value;
           datWorkGroup_info.Call();  
        break;
        case  "datFind_Report":
          {
            if(lstReport.value =="1")
            {
                var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text + '?pk_list=' + pk_list;
            }
            else if(lstReport.value == "2")
            {

                var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text + '?l_sal=' + txt_sal_security.text +'&l_from_org=' + lstOrg1.value  ;
                    url = url + '&l_to_org='+ lstOrg2.value+ '&l_from_pos='+lstPos1.value+'&l_to_pos='+lstPos2.value+'&l_emp_status='+lstStatus.value  ;
                    url = url + '&l_search_by='+ idSearch.value+'&l_search_temp='+idtxtTmp.text+'&l_from_app='+dtFrom.value+'&l_to_app='+dtTo.value+'&l_change='+lstChange.value ;
            }
            else if(lstReport.value == "3")
            {

                var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text + '?l_sal=' + txt_sal_security.text +'&l_from_org=' + lstOrg1.value  ;
                    url = url + '&l_to_org='+ lstOrg2.value+ '&l_from_pos='+lstPos1.value+'&l_to_pos='+lstPos2.value+'&l_emp_status='+lstStatus.value  ;
                    url = url + '&l_search_by='+ idSearch.value+'&l_search_temp='+idtxtTmp.text+'&l_from_app='+dtFrom.value+'&l_to_app='+dtTo.value+'&l_change='+lstChange.value ;
            }
            window.open(url);
          }
        break;
    }
    
}
//---------------------------------------------------------
function OnShowPopup(obj1)
{
    var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			obj1.value = obj;
            
        }
}
//----------------------------------------------------
function OnAdd()
{
    //add wgroup to grid    
           var arr = txt_WG_temp1.text.replace("DATA|",'').split("|");
           var s="";
           var t=0;
	           for(var i=0;i< (arr.length+1)/2-1;i++)
	            {
		            s = s +"#" + arr[t] + ";" + arr[t+1]+"|";
		            t=t+2;
		        }
	       grdApp.SetComboFormat(o_to_wg,s  );

    ctrl =grdApp.GetGridControl();
    if(ctrl.rows>1)
    { 
        for(var j=1; j<ctrl.rows; j++)
        {
           if(grdApp.GetGridData(j,c_pk)!="")
           {
                grdApp.RemoveRowAt(j);
                j--;
           }
        }
        idRecord.text = "0 (recs)";
    }

    var rowid,k,tmp;
	var url = "/form/ch/ae/chae00600_add_emp.aspx";
	var aData=new Array();
	aData = System.OpenModal( System.RootURL + url , 900 , 600 , 'resizable:yes;status:yes') ;
	if ( aData != null )
	{  	 
		var len=aData.length;
		var i;
		for (i=0;i<len;i++)		
		{
	            grdApp.AddRow();
		        var irow=grdApp.rows-1;
		        aRow=aData[i];
		        
		        

		        grdApp.SetGridText(irow,c_Emp_ID,aRow[0]);		// emp_id
		        grdApp.SetGridText(irow,c_Full_Name,aRow[1]);		// full_name
		        grdApp.SetGridText(irow,c_From_Org,aRow[2]);		// from_department
		        grdApp.SetGridText(irow,c_From_Position,aRow[3]);  // from_position
		        grdApp.SetGridText(irow,c_To_Org,aRow[2]);		// to_department
		        
		        grdApp.SetGridText(irow,c_To_Position,aRow[9]);  //to_position
		        grdApp.SetGridText(irow,c_From_Manager,aRow[5]);		// manager name
		        grdApp.SetGridText(irow,c_Old_Salary,aRow[6]);		// Salary
		        grdApp.SetGridText(irow,c_New_Salary,aRow[6]);		// Salary
		        grdApp.SetGridText(irow,c_THR_EMP_PK,aRow[7]);		// thr_emp_pk
		        grdApp.SetGridText(irow,c_FROM_ORG_PK,aRow[8]);		// FROM_ORG_PK
		        grdApp.SetGridText(irow,c_FROM_POS_TYPE,aRow[9]);		// FROM_POS_TYPE
		        grdApp.SetGridText(irow,c_TO_ORG_PK,aRow[8]);		// TO_ORG_PK
		        
		        grdApp.SetGridText(irow,c_FROM_MANAGER_ID,aRow[10]);		// MANAGER_PK
		        grdApp.SetGridText(irow,c_FROM_MANAGER_ORG_PK,aRow[11]);		// MANAGER_ORG_PK
		        grdApp.SetGridText(irow,c_FROM_MANAGER_POS_PK,aRow[12]);		// MANAGER_POS_PK
		        
		        grdApp.SetGridText(irow,c_App_Date,aRow[13]);		// SYSDATE
		        grdApp.SetGridText(irow,c_From_WG,aRow[15]);		// From WG
		        grdApp.SetGridText(irow,c_To_WG,aRow[14]);		// To WG
		        grdApp.SetGridText(irow,c_From_WG_PK,aRow[14]);		// To WG
                grdApp.SetGridText(irow,c_From_Education,aRow[4]);		// From Education
                grdApp.SetGridText(irow,c_To_Education,aRow[16]);		// To Education
                grdApp.SetGridText(irow,c_From_Education,aRow[16]);		// From Education
		        

		}
	}	

}
//------------------------------------------------------------------------
function Popup()
{
    var col=event.col;
    if(col==c_To_Org)
    {
        
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00600_org.aspx?";
        var obj  = System.OpenModal(  fpath , 700 , 600 , 'resizable:yes;status:yes');
        //var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            rowclick= event.row;
             txtOrgPK.text = obj;
			 grdApp.SetGridText(event.row,c_TO_ORG_PK,txtOrgPK.text);
           
            datGet_Org.Call();

        }    
    }
}
//-------------------------------------------------------
function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tblDetail.style.display="none";
			tblDetail.style.height="0%";
			tblMaster.style.height="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show old Appointment";
			
        }
        else
        {
            imgMaster.status = "expand";
            tblDetail.style.display="";
            tblDetail.style.height="30%";
            tblMaster.style.height="70%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close old Appointment";
			OnShowOld();
			
        }
  
}
//------------------------------------------
function OnShowOld()
{
    if (imgMaster.status=="expand")
    {
        var irow=grdApp.row;
        if (irow>=1)
        {
            txtEmp_PK.text=grdApp.GetGridData(irow,c_THR_EMP_PK);
            txtTimes.text = grdApp.GetGridData(irow,c_Times);
            datApp_old.Call("SELECT");
        }
        else
        {
            datApp_old.ClearData();
        }
    }
}
//-------------------------------------------------------------
function OnReport()
{
        if(lstReport.value == "1")
        {   
            pk_list="";
            for (var i=1;i<=grdApp.rows-1;i++)
            {
                if (grdApp.GetGridData(i,c_select)!="0")    
                        pk_list = pk_list + grdApp.GetGridData(i,c_pk) + ",";  
            }
            for (var i=1;i<=grdApp_old.rows-1;i++)
            {
                if (grdApp_old.GetGridData(i,0)!="0")      
                    
                        pk_list = pk_list + grdApp_old.GetGridData(i,o_pk) + ",";  
            }
            if (pk_list!="")
            {   
                txtReport_tmp.text="rpt_decision_appointment.aspx";
                datFind_Report.Call();
            }
            else
            {
                alert("Please select employees to report! \n Vui lòng chọn nhân viên để in!");
            }
        }
        else if(lstReport.value == "2")
        {
            txtReport_tmp.text="rpt_appointment_summary.aspx";
            datFind_Report.Call();
        }
        else if(lstReport.value == "3")
        {
            txtReport_tmp.text="rpt_appointment_detail.aspx";
            datFind_Report.Call();
        }

    
}
function OnChangeSetBy()
{
    //OnResetList();
    if(lstSetBy.value =="1") // organization
    {
        td0.style.display="none" ;
        td1.style.display ="block" ; // show
        td2.style.display="none" ;   // not show    
        td3.style.display="none" ;
        td4.style.display="none" ;
        td5.style.display="none" ;
        td6.style.display="none" ;
        tdset.style.display="block" ;
    }
    else if(lstSetBy.value == "2") // Work group 
    {
        td0.style.display="none" ;
        td1.style.display ="none" ; 
        td2.style.display="block" ;  
        td3.style.display="none" ;
        td4.style.display="none" ;
        td5.style.display="none" ;
        td6.style.display="none" ;
        tdset.style.display="block" ;
    }
    else if(lstSetBy.value == "3") // Position
    {
        td0.style.display="none" ;
        td1.style.display ="none" ; 
        td2.style.display="none" ;  
        td3.style.display="block" ;
        td4.style.display="none" ;
        td5.style.display="none" ;
        td6.style.display="none" ;
        tdset.style.display="block" ;
    }
    else if(lstSetBy.value == "4") // Education
    {
        td0.style.display="none" ;
        td1.style.display ="none" ; 
        td2.style.display="none" ;  
        td3.style.display="none" ;
        td4.style.display="block" ;
        td5.style.display="none" ;
        td6.style.display="none" ;
        tdset.style.display="block" ;
    }
    else if(lstSetBy.value == "5"||lstSetBy.value == "6") // App Date , Approve Date
    {
        td0.style.display="none" ;
        td1.style.display ="none" ; 
        td2.style.display="none" ;  
        td3.style.display="none" ;
        td4.style.display="none" ;
        td5.style.display="block" ;
        td6.style.display="none" ;
        tdset.style.display="block" ;
    }
    else if(lstSetBy.value == "7") // Reason
    {
        td0.style.display="none" ;
        td1.style.display ="none" ; 
        td2.style.display="none" ;  
        td3.style.display="none" ;
        td4.style.display="none" ;
        td5.style.display="none" ;
        td6.style.display="block" ;
        tdset.style.display="block" ;
    }
    else 
    {
        td0.style.display="block" ;
        td1.style.display ="none" ; 
        td2.style.display="none" ;  
        td3.style.display="none" ;
        td4.style.display="none" ;
        td5.style.display="none" ;
        td6.style.display="none" ;
        tdset.style.display="none" ;
    }
}
function OnSetGrid()
{
    if(lstSetBy.value =="" )
    {
        alert("Please choose value to set\nBạn phải chọn giá trị để set.");
        return;
    }
    else 
    {
        var ctrl=grdApp.GetGridControl();
        for(var i=1;i<=ctrl.SelectedRows;i++)
        {
            if(lstSetBy.value == "1") //Organization
            {   
                if(lstOrg_Set.value =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_TO_ORG_PK ,lstOrg_Set.value );
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_To_Org ,lstOrg_Set.GetText() );
            }
            else if(lstSetBy.value =="2") //Work Group
            {
                if(lstGrp_Set.value =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_To_WG ,lstGrp_Set.value );
            }
            else if(lstSetBy.value =="3") //Position
            {
                if(lstPos_Set.value =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_To_Position ,lstPos_Set.value );
            }
            else if(lstSetBy.value =="4") //Education
            {
                if(lstEdu_Set.value =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_To_Education ,lstEdu_Set.value );
            }
            else if(lstSetBy.value =="5") //App Date
            {
                if(dt_Set.value =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_App_Date ,dt_Set.value );
            }
            else if(lstSetBy.value =="6") //Approve Date
            {
                if(dt_Set.value =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_Approve_DT ,dt_Set.value );
            }
            else if(lstSetBy.value =="7") //Reason
            {
                if(txtValue.text =="" )
                {
                    alert("Please choose value to set\nBạn phải chọn giá trị để set.");
                    return;
                }
                grdApp.SetGridText(ctrl.SelectedRow(i-1),c_Description ,txtValue.text );
            }
            
        }
        
    }
}


</script>

<body>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR.sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-- Kiem tra quyen xem luong ---------------------------------------->
    <gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
            <xml>
                <dso  type="process" procedure="hr_pro_10010003_sal_display"  > 
                    <input>
                        <input bind="iduser_pk" />
                    </input> 
                    <output>
                        <output bind="txt_sal_security" />
                    </output>
                </dso> 
            </xml> 
    </gw:data>

<!--------------------------------------------------------------->
<gw:data id="datAppointment" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_SEL_10010060_emp_app" procedure="hr_upd_10010060_emp_app" parameter="0,2,9,11,12,13,15,16,17,18,20,21,22,23,24,25,26,27,28,29" > 
                <input bind="grdApp">
                    <input bind="lstOrg1" /> 
                    <input bind="lstPos1" /> 
                     <input bind="lstOrg2" />
                    <input bind="lstPos2" />
                    <input bind="idSearch" /> 
                    <input bind="idtxtTmp" />
                    <input bind="lstStatus" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="lstChange" />
                </input> 
                <output bind="grdApp"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->

<gw:data id="datGet_Org" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_ORG" > 
                <input>
                    <input bind="txtOrgPK" />
                </input> 
                <output>
                    <output bind="txtOrgNM" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datApp_old" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="hr_SEL_10010060_APP_OLD" > 
                <input bind="grdApp_old" >
                    <input bind="txtEmp_PK" /> 
                    <input bind="txtTimes" />
                </input>
                <output  bind="grdApp_old" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="txtOrgPK" />
                </input> 
                <output>
                    <output bind="txt_WG_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------->

    <table  id="tblEvent" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" colspan=5 style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(lstOrg1)" href="#tips" >
                            <b>From Organization</a>                  
                        </td>
                        <td width="22%" colspan=11 style="border:0;" align="left" >
                             <gw:list  id="lstOrg1" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
                        <td width="10%" colspan=5 style="border:1;" align="right" ><b>From Position</b></td>
                        <td width="16%" colspan=8 style="border:1;" align="left" >
                             <gw:list  id="lstPos1" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                                </data></gw:list>
                        </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle">Search by</td>
					    <td  style="border:0" colspan=4 width="8%" >
					        <gw:list  id="idSearch" value="2" styles='width:100%'> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="10%" align=center  colspan=5 style="border:0" > 
					        <gw:textbox id="idtxtTmp" onenterkey   ="OnSearch()" styles='width:95%'/>
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch3"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td  width="2%" style="border:0" align="right">
                         
                        </td>
                        <td  width="2%" style="border:0" align="right">
                         <gw:imgbtn id="btnAdd" img="new" alt="Add" onclick="OnAdd()" />
                        </td>
                         <td width="2%"  style="border:0;" align="left" >
                         <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                        <td width="2%"  style="border:0;" align="left" >
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                    </tr>
                    
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" colspan=5 style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(lstOrg2)" href="#tips" >
                            <b>To Organization</a>                  
                        </td>
                        <td width="22%" colspan=11 style="border:0;" align="left" >
                             <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                                <data>
                                   <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
                        <td width="10%" colspan=5 style="border:1;" align="right" ><b>To Position</b></td>
                        <td width="14%" colspan=8 style="border:1;" align="left" >
                             <gw:list  id="lstPos2" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                                </data></gw:list>
                        </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle"><b>Status</b></td>
					    <td  style="border:0" colspan=4 width="8%" >
					       <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
				        </td>
                        
                        <td width="10%" colspan=5 style="border:0;" align="right" >
                         <label style="color:red" >Report by</label>
                        </td>
                        <td colspan=4 width="8%" style="border:0" align="left">
                            <gw:list  id="lstReport" value='1' styles='width:100%' >
                               <data>
                                    |1|Decision|2|Summary|3|Detail
                                </data></gw:list>
                        </td>
                         <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="excel" id="ibtnReport3"    alt="Report"  onclick="OnReport()"/>
                        </td>
                        
                        
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 style="border:0;" align="right" ><b>Appointment by</b></td>
                        
                        <td colspan=11 style="border:0"> 
                             <gw:list  id="lstChange" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>|ALL|Select All|1|Organization|2|Position|3|Education</data></gw:list>
                        </td>
                         <td colspan=7 style="border:0;" align="right" ><b>Appointment date </b></td>
                        
                        <td colspan=2 style="border:0;"  align="center" ></td>
                        <td colspan=4 style="border:0;"  align="left" > <gw:datebox id="dtFrom" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" />
                            
                        </td>
                         <td align=center  colspan=2 style="border:0" ><b>~</b></td>
                         <td align=center  colspan=4 style="border:0" ><gw:datebox id="dtTo" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" /></td>
                         <td align=right  colspan=3 style="border:0" ></td>
                       <td style="border:0" colspan=8 align="right" ><gw:label id="idRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                       <td style="border:0" colspan=4 align="right" >
                            <img status="collapse" id="imgMaster" alt="Show old Discipline" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  />
                       </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" colspan=5 style="border:0;" align="right" >
                            <font color="FF3399">Set by
                        </td>
                        <td width="10%" colspan=5 style="border:0;" align="left" >
                             <gw:list  id="lstSetBy" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeSetBy()" >
                            <data>|||1|Organization|2|Work group|3|Position|4|Education|5|Appoint Date|6|Approve Date|7|Reason</data></gw:list>
                        </td>
                        <td id="td0" width="12%" colspan=6 style="border:0;" align="left" >
                            &nbsp;
                        </td>
                        <td id="td1" width="12%" colspan=6 style="border:0;display:none" align="left" >
                             <gw:list  id="lstOrg_Set" value=' ' maxlen = "100" styles='width:100%'onchange="" >
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>||
                                </data>
                            </gw:list>
                        </td>
                        <td id="td2" width="12%" colspan=6 style="border:0;display:none" align="left" >
                            <gw:list  id="lstGrp_Set" value=' ' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>||</data></gw:list>
                        </td>
                        <td id="td3" width="12%" colspan=6 style="border:0;display:none" align="left" >
                            <gw:list  id="lstPos_Set" value=' ' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>||
                                </data></gw:list>
                        </td>
                        
                        <td id="td4" width="12%" colspan=6 style="border:0;display:none" align="left" >
                            <gw:list  id="lstEdu_Set" value=' ' maxlen = "10" styles='width:100%' > 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0011' order by seq")%>||
                            </data>
                            </gw:list>
                        </td>
                        <td id="td5" width="12%" colspan=6 style="border:0;display:none" align="left" >
                            <gw:datebox id="dt_Set" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td id="td6" width="12%" colspan=6 style="border:0;display:none" align="left" >
                            <gw:textbox id="txtValue"  styles='width:100%'/>
                        </td>
                        
                        <td id="tdset" width="10%" colspan=5 style="border:1;display:none" align="left" >
                            <gw:imgBtn id="ibtnSet" alt="Set Grid" img="set" text="Set Grid" onclick="OnSetGrid()" />
                        </td>
                        <td width="14%" colspan=8 style="border:1;" align="left" >
                           
                        </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle"></td>
					    <td  style="border:0" colspan=4 width="8%" >
					       
				        </td>
                        <td width="8%" colspan=4 style="border:0;" align="right" >
                            
                        </td>
                        <td colspan=8 width="8%" style="border:0" align="center">
                            
                        </td>
                         <td width="2%" style="border:0;" align="right" >
                            
                        </td> 
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=50  style="width:100%;height:100%;"> 
                              <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:100%" valign="top">
                                    <td>
                                     <gw:grid   
                                        id="grdApp"  
                                        header="_PK|Select|Emp ID|Full Name|From Organization|From Workgroup|From Position|From Education|From Manager|Old Salary|To Organization|To Workgroup|To Position|To Education|To Manager|New Salary|App Date|Approve DT|Reason|Times|_THR_EMP_PK|_FROM_ORG_PK|_FROM_POS_PK|_TO_ORG_PK|_FROM_MANAGER_ID|_FROM_MANAGER_ORG_PK|_FROM_MANAGER_POS_PK|_FROM_WG_PK|_FROM_EDUCATION_PK|Appointment Type"
                                        format='0|3|0|0|0|0|0|0|0|1|0|2|2|2|0|1|4|4|0|0|0|0|0|0|0|0|0|0|0|0' 
                                        aligns='0|1|0|0|0|0|0|0|0|0|0|0|0|0|1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0'
                                        defaults='|||||||||||||||||||||||||||||' 
                                        editcol='0|1|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|1' 
                                        widths='1000|800|1000|2000|2300|2000|2000|2000|2500|1500|2000|2000|2000|2000|2000|2000|1500|1500|3000|500|0|0|0|0|0|0|0|0|0|800'
                                        sorting='T' 
                                        styles='width:100%; height:100%' 
                                        oncelldblclick = "Popup()"
                                        oncellclick="OnShowOld()"
                                        acceptnulldate='T' />
                                     </td>
                                 </tr>
                             </table>
                             <table width="100%" id="tblDetail" style="height:30%;display:none" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%" valign="top">
                                    <td > 
                                         <gw:grid   
                                            id="grdApp_old"  
                                            header="_PK|Select|Emp ID|Full Name|From Organization|From Workgroup|From Position|From Education|From Manager|Old Salary|To Organization|To Workgroup|To Position|To Education|To Manager|New Salary|App Date|Approve Date|Description|Times|Appointment Type"
                                            format='0|3|0|0|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0' 
                                            aligns='0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0'
                                            defaults='|||||||||||||||||||||' 
                                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                                            widths='1000|800|1000|2000|2300|1500|2000|2000|1500|2500|1500|2000|2000|2000|2000|1500|1500|1500|1500|800|800'
                                            sorting='T' 
                                            styles='width:100%; height:100%'
                                            acceptnulldate='T' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>  

    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display:none" />
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>
    <gw:textbox id="txtOrgPK" styles="display:none"/>
    <gw:textbox id="txtOrgNM" styles="display:none"/>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtTimes" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="txtidmenu" text="139" styles="display:none"/>
    <gw:textbox id="txtflag_menu" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 
    <gw:textbox id="txt_WG_temp1" styles="display:none"/>
	<gw:textbox id="txt_WG_temp" styles="display:none"/>
    <!------------------------------------------->
</body>
</html>
