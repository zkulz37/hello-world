<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPOINTMENT EXECUTE</title>
</head>
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;

var flag_header=true;
var imp_seq;
var flag_imp=0;
var flag_del=0;
var c_Factory = 0,
    c_Department =1,
    c_Group= 2,
    c_Position= 3,
    c_Emp_ID= 4,
    c_Full_Name= 5,
    c_Join_Date=6,
    c_Left_Date=7,
    c_Previous=8,
    c_Education=9,
    c_Month = 10,
    c_Month_Inc_Sal = 11,
    c_Result_vn=12,
    c_Reason_vn=13,
    c_Result_kor=14,
    c_Reason_kor=15,
    c_Issues_Date=16,
    c_Old_Salary=17,
    c_Inc_Amt=18,
    c_New_Salary=19,
    c_Status_Imp = 20,
    c_Remark = 21,
    c_pk = 22,
    c_imp_seq =23;
    

function BodyInit()
{

    System.Translate(document);  // Translate to language session
    iduser_pk.text = "<%=session("USER_PK")%>";
    
     var  t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,code from vhr_hr_code where id='HR0152' ")%>";
       grdEval.SetComboFormat(c_Result_vn,t1); 
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,code from vhr_hr_code where id='HR0152' ")%>";
       grdEval.SetComboFormat(c_Result_kor,t1); 
    grdEval.GetGridControl().FrozenCols =5;
    SetGridHeader();
    OnToggle();
    datCheck_Fromto.Call();
}


 //------------------------------------------------------------------------------------
function OnCreate()
{
    if(confirm("Do you want to create evaluation list?\nBạn muốn tạo danh sách đánh giá?"))
        datCreate_Eval.Call();
}
function onchange_month()
{
    datCheck_Fromto.Call();
}
 //------------------------------------------------------------------------------------
function OnSave()
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
    {
        if(flag_imp == "1") // import
            datImpEval.Call();
        else 
            datgrdEval.Call();
    }
}
//-------------------------------------------------------------------------------------
function OnSearch()
{
    datgrdEval.Call("SELECT");
}
//--------------------------------------------------------------------------------------------------
function OnDelete(obj)
{
    if(obj == "1")
    {
        if(confirm("Delete it?\nBạn muốn xóa?"))
            grdEval.DeleteRow();
    }
    else if(obj =="2")
    {
        datCheck_Fromto.Call();
        flag_del =1;
        
    }
}
//--------------------------------------------------------------------------------------------------
function OnPrint(obj)
{
    if(obj=="1") // report example
    {
        url =System.RootURL + '/reports/ch/cs/rpt_template_evaluation_worker.aspx';
            window.open(url); 
    }
    else if(obj=="2")
    {
        url =System.RootURL + '/reports/ch/cs/rpt_evaluate_worker_hyosung.aspx?l_dept='+ lstOrg.value +'&l_group='+ lstWG.value +'&l_position='+ lstPos.value+
                                '&l_search='+ idSearch.text +'&l_txtTmp='+ idtxtTmp.text +'&l_work_mon='+ dtMonth.value +'&l_status='+ lstStatus.value ;
            window.open(url); 
    }
}
//---------------------------------
function OnDataReceive(obj)
{
   if(obj.id=="datCheck_Fromto")
   {
       if(flag_del== 1 )
       {
         if(txtImp_YN.text == "Y")
            {
                alert("You have delete import data\nBạn phải xóa tất cả dữ liệu đã import!")
                return;
            }
            else 
            {   
                if(confirm("Delete it?\nBạn muốn xóa?"))
                datDel_data.Call();
            }
       }
       else
       {
            if(txtData_YN.text == "Y")
            {
                btnCreate.SetEnable(0);
                idStatus.text = "Yes"
            }
            else
            {
              btnCreate.SetEnable(1);
              idStatus.text = "No"
            }
        }
   }
   else if(obj.id =="datCreate_Eval")
   {
        if(txtFlag_Eval.text =="Y")
        {
            alert("Create success!\n Tạo thành công!");
            btnCreate.SetEnable(0);
            idStatus.text = "Yes";
           datgrdEval.Call("SELECT");
        }   
        else alert("Create Fail!\n Tạo không thành công!");
   }
   else if(obj.id=="datgrdEval")
   {
        
        SetGridHeader();
        idRecord.text=grdEval.rows-2+" Rec(s)";
        auto_resize_column(grdEval,0,grdEval.cols-1,0);

        for (var i =2 ;i < grdEval.rows ; i++)
        {
            if(grdEval.GetGridData(i,c_Month)!= grdEval.GetGridData(i,c_Month_Inc_Sal))
                grdEval.SetCellBgColor(i,0,i,c_imp_seq,0xBAEDD3);

            if(grdEval.GetGridData(i, c_Month_Inc_Sal)!= dtMonth.value.substr(4,2)+ '/' + dtMonth.value.substr(0,4))
                grdEval.SetCellFontColor(i, 0,i, c_imp_seq, 0x300FF3 );

        }
   }
   else if(obj.id=="datImpEval")
   {
        
        SetGridHeader();
        idRecord.text=grdEval.rows-2+" Rec(s)";
        flag_imp =0;
        auto_resize_column(grdEval,0,grdEval.cols-1,0);
   }
   else if(obj.id == "datDel_data")
   {
        if(txtTmp.text == "Y")
        {
            alert("Delete success!\nXóa thành công!");
            btnCreate.SetEnable(1);
            idStatus.text = "No"
            flag_del=0;
        }
        else
        {
            alert("Delete fail!\nXóa thất bại!");
        }
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

//-------------------------------------------------
function SetGridHeader()
{
    var stt;
    
        var fg=grdEval.GetGridControl(); 	  

            if (flag_header==true)
            {
                fg.rows=fg.rows+1;
                flag_header=false;
            }

        fg.FixedRows = 2;
        fg.FixCols=1;
        fg.MergeCells =5	;
        stt=0;//num column
        fg.MergeCol(c_Factory) =true	;
        fg.Cell(0, 0, c_Factory, 1, c_Factory)  = "Factory";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(c_Department) =true	;
        fg.Cell(0, 0, c_Department, 1, c_Department)  = "Department";

        fg.MergeCol(c_Group) =true	;
        fg.Cell(0, 0, c_Group, 1, c_Group)  = "Group";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_Position) =true	;
        fg.Cell(0, 0, c_Position, 1, c_Position)  = "Position";   //fg.Cell(0,row, from_col, row, to_col)
        	
        fg.MergeCol(c_Emp_ID) =true	;
        fg.Cell(0, 0, c_Emp_ID, 1, c_Emp_ID)  = "Emp ID";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_Full_Name) =true	;
        fg.Cell(0, 0, c_Full_Name, 1, c_Full_Name)  = "Full Name";   //fg.Cell(0,row, from_col, row, to_col)

        fg.MergeCol(c_Join_Date) =true	;
        fg.Cell(0, 0, c_Join_Date, 1, c_Join_Date)  = "Join Date";   //fg.Cell(0,row, from_col, row, to_col)	

         fg.MergeCol(c_Left_Date) =true	;
        fg.Cell(0, 0, c_Left_Date, 1, c_Left_Date)  = "Left Date";   //fg.Cell(0,row, from_col, row, to_col)

        fg.MergeCol(c_Previous) =true	;
        fg.Cell(0, 0, c_Previous, 1, c_Previous)  = "Previous Result";   //fg.Cell(0,row, from_col, row, to_col)
        	
        fg.MergeCol(c_Education) =true	;
        fg.Cell(0, 0, c_Education, 1, c_Education)  = "Education";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_Month) =true	;
        fg.Cell(0, 0, c_Month, 1, c_Month)  = "Eval Month";   //fg.Cell(0,row, from_col, row, to_col)

        fg.MergeCol(c_Month_Inc_Sal) =true	;
        fg.Cell(0, 0, c_Month_Inc_Sal, 1, c_Month_Inc_Sal)  = "Inc Sal Month";   //fg.Cell(0,row, from_col, row, to_col)
        
        fg.MergeRow(0) =true	;
        fg.Cell(0, 0, c_Result_vn, 0, c_Reason_vn)  = "VIETNAM MANAGER";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, c_Result_vn, 1, c_Result_vn) = "Result";
        fg.Cell(0, 1, c_Reason_vn, 1, c_Reason_vn) = "Reason";
        
        fg.MergeRow(0) =true	;
        fg.Cell(0, 0, c_Result_kor, 0, c_Reason_kor)  = "KOREAN MANAGER";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, c_Result_kor, 1, c_Result_kor) = "Result";
        fg.Cell(0, 1, c_Reason_kor, 1, c_Reason_kor) = "Reason";

           
        fg.MergeCol(c_Issues_Date) =true	;
        fg.Cell(0, 0, c_Issues_Date, 1, c_Issues_Date)  = "Issues Date";   //fg.Cell(0,row, from_col, row, to_col)
        	
        fg.MergeCol(c_Old_Salary) =true	;
        fg.Cell(0, 0, c_Old_Salary, 1, c_Old_Salary)  = "Old Salary";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_Inc_Amt) =true	;
        fg.Cell(0, 0, c_Inc_Amt, 1, c_Inc_Amt)  = "Increase AMT";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_New_Salary) =true	;
        fg.Cell(0, 0, c_New_Salary, 1, c_New_Salary)  = "New Salary";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_Status_Imp) =true	;
        fg.Cell(0, 0, c_Status_Imp, 1, c_Status_Imp)  = "Import YN";   //fg.Cell(0,row, from_col, row, to_col)	

        fg.MergeCol(c_Remark) =true	;
        fg.Cell(0, 0, c_Remark, 1, c_Remark)  = "Remark";   //fg.Cell(0,row, from_col, row, to_col)

        fg.MergeCol(c_pk) =true	;
        fg.Cell(0, 0, c_pk, 1, c_pk)  = "_PK";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(c_imp_seq) =true	;
        fg.Cell(0, 0, c_imp_seq, 1, c_imp_seq)  = "_SEQ";   //fg.Cell(0,row, from_col, row, to_col)	
        
        grdEval.SetCellBold(1,1,1,c_imp_seq,true);

}
//------------------------------
function CheckValidFile(vfile)
{
    var sext1,sext2;
    sext1=vfile.substring(vfile.length-4,vfile.length);
    sext2=vfile.substring(vfile.length-5,vfile.length);
    if (sext1!=".xls" && sext2!=".xlsx")
        return false;
    return true;
}
//-----------------------------
function OnLoadExcel()
{
 
 grdEval.ClearData();	
 imp_seq = new Date().getTime();
 txtImp_Seq.text= imp_seq;
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,v_name, v_month, v_result_vn, v_reason_vn, v_result_kor, v_reason_kor;;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,1).value;    
			v_name=workSheet.Cells(j,2).value;
            v_month = workSheet.Cells(j,3).value;
            v_result_vn = workSheet.Cells(j,4).value;
            v_reason_vn = workSheet.Cells(j,5).value;
            v_result_kor = workSheet.Cells(j,6).value;
            v_reason_kor = workSheet.Cells(j,7).value;                    
											
			if (vemp_id=="")
			   alert("Emp-ID cannot be blank at row: " + j);
			 
			else
			{                             
				grdEval.AddRow();
				var irow=grdEval.rows-1;
				grdEval.SetGridText(irow,c_Emp_ID,vemp_id);
                grdEval.SetGridText(irow,c_Full_Name, v_name);
                grdEval.SetGridText(irow,c_Month, v_month);
                grdEval.SetGridText(irow,c_Result_vn, v_result_vn);
                grdEval.SetGridText(irow,c_Reason_vn, v_reason_vn);
                grdEval.SetGridText(irow,c_Result_kor, v_result_kor);
                grdEval.SetGridText(irow,c_Reason_kor, v_reason_kor);
			                				 
                grdEval.SetGridText(irow,c_imp_seq, imp_seq);			                				                 
			}			
		} 
		flag_imp = 1;
		myApp.Quit();
		//SetGridHeader()
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?");
		myApp.Quit(); 
	}	
    Remove_empty_rows();
}
//----------------------------------
function Remove_empty_rows()
{
    var tmp=0;
    var i=1;
  if(grdEval.GetGridControl().rows>2)
  {
    var row=grdEval.GetGridControl().rows;
    
    while(i<row)
    {
        if(grdEval.GetGridData(i,c_Emp_ID).length<4 || grdEval.GetGridData(i,c_Month).length != 7 )
        {   
            grdEval.RemoveRowAt(i);
            i-=1;
            row=grdEval.GetGridControl().rows;
        }
        i+=1;    
    }
    
    idRecord.text=grdEval.rows-1 + " records."
    auto_resize_column(grdEval,0,grdEval.cols-1,0);
  } 
  
  //clear_Interval(idRecord);
  
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-------------------------------------------------------------------
function OnToggle()
{
    
            if(img2.status == "show")
            {
                img2.status = "hide";
                img2.src = "../../../system/images/close_popup.gif";
			    img2.alt="Hide evaluation worker Data";
			    tr1.style.display='';
			    tr1.style.height="5%";
			    tr2.style.height="5%";
			    tr3.style.height="5%";
			    tr4.style.height="5%";
			    tr5.style.height="80%";
			    
            }
            else 
            {
                img2.status = "show";
                img2.src = "../../../system/images/iconmaximize.gif";
			    img2.alt="Show evaluation worker Data";
			    tr1.style.display='none';
			    tr1.style.height="0%";
			    tr2.style.height="5%";
			    tr3.style.height="5%";
			    tr4.style.height="5%";
			    tr5.style.height="85%";
            }
  
}
</script>

<body>
<!------------------------------------------------------>
<gw:data id="datDel_data" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030021_del_data" > 
                <input >
                    <input bind="dtMonCrt" />  
                </input>
                <output >
                    <output bind="txtTmp" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datCheck_Fromto" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_month_from_to" > 
                <input >
                    <input bind="dtMonCrt" />  
                </input>
                <output >
                    <output bind="txtFrom" /> 
                    <output bind="txtTo" /> 
                    <output bind="txtData_YN" /> 
                    <output bind="txtImp_YN" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datCreate_Eval" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030021_crt_eval" > 
                <input >
                    <input bind="dtMonCrt" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />  
                </input>
                <output >
                    <output bind="txtFlag_Eval" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datgrdEval" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="4,10,12,13,14,15,16,21,22,23" function="hr_sel_10030021_evaluate" procedure="hr_upd_10030021_evaluate"> 
                <input bind="grdEval" >
                   <input bind="lstOrg" /> 
                   <input bind="lstWG" />
                   <input bind="lstPos" />
                   <input bind="idSearch" />
                   <input bind="idtxtTmp" />
                   <input bind="lstStatus" />
                   <input bind="dtMonth" />
                   <input bind="lstIncSal" />
                </input>
                <output  bind="grdEval" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datImpEval" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" parameter="4,10,12,13,14,15,16,21,22,23" function="hr_sel_10030021_imp_eval" procedure="hr_upd_10030021_evaluate"> 
                <input bind="grdEval" >
                   <input bind="txtImp_Seq" /> 
                   <input bind="dtMonth" />
                </input>
                <output  bind="grdEval" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->

    <table  id="tblEvent" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    
                    <tr id="tr1" style="border:0;width:100%;height:5%" valign="center" >
                        
                        <td width="32%" colspan=16 style="border:0;" align="right" >
                            Data for evaluation worker period month
                        </td>
                        <td width="10%" colspan=5 style="border:1;" align="right" >
                            <gw:datebox id="dtMonCrt" lang="<%=Session("Lang")%>" styles="width:90%" onchange="onchange_month()" type=month></gw:datebox>
                        </td>
                        <td width="2%" colspan=1 style="border:1;" align="left" >
                            
                        </td>
                        <td width="2%" colspan=1 style="border:1;" align="left" >
                            <gw:imgBtn img="process" id="btnCreate" alt="Create Evaluation" onclick="OnCreate()"/>
                        </td>
                        <td width="2%" colspan=1 style="border:1;" align="left" >
                            
                        </td>
                        <td width="2%" colspan=1 style="border:1;" align="left" >
                            <gw:imgbtn id="btnDelCrt" img="delete" alt="Delete Data" onclick="OnDelete(2)" />
                        </td>
                        <td width="2%" colspan=1 style="border:1;" align="left" >
                            
                        </td>
                        <td width="2%" colspan=1 style="border:1;" align="left" >
                            Data
                        </td>
                        <td width="4%" colspan=2 style="border:1;" align="right" >
                            <gw:label id="idStatus"  text="" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" />
                        </td>
                        <td  style="border:0"  width="8%" colspan=4 align="right" valign="middle"></td>
					    <td  style="border:0" colspan=7 width="14%" >
					         
				        </td>
                        <td width="4%" align=center  colspan=2 style="border:0" > 
					        
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         
                        </td>
                        <td  width="2%" style="border:0" align="right">
                         
                        </td>
                        <td  width="2%" style="border:0" align="right">
                         
                        </td>
                         <td width="2%"  style="border:0;" align="left" >
                         
                        </td>
                        <td width="2%"  style="border:0;" align="left" >
                         
                        </td>
                    </tr>
               
                    <tr id="tr2" style="border:0;width:100%;height:5%" valign="center" >
                        <td width="2%" colspan="1" style="border:0;" align="center">
                           <img status="hide" id="img2" alt="Show data evaluation worker" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle()"  />
                        </td>
                        <td width="10%" colspan=5 style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(lstOrg)" href="#tips" >
                            <b>Organization</a>                  
                        </td>
                        <td width="20%" colspan=10 style="border:0;" align="left" >
                             <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                                <data>
                                    <%= ESysLib.SetListDataSQL("select pk,org_nm from tco_org a where del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
                        <td width="10%" colspan=5 style="border:1;" align="right" ><b>Work Group</b></td>
                        <td width="16%" colspan=8 style="border:1;" align="left" >
                             <gw:list  id="lstWG" value="ALL"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle"><b>Position</b></td>
					    <td  style="border:0" colspan=7 width="14%" >
					         <gw:list  id="lstPos" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                                </data></gw:list>
				        </td>
                        <td width="4%" align=center  colspan=2 style="border:0" > 
					        
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch3"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td  width="2%" style="border:0" align="right">
                         
                        </td>
                        <td  width="2%" style="border:0" align="right">
                         
                        </td>
                         <td width="2%"  style="border:0;" align="left" >
                         <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                        <td width="2%"  style="border:0;" align="left" >
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete(1)" />
                        </td>
                    </tr>
                    
                    <tr id="tr3" style="border:0;width:100%;height:5%" valign="center" >
                        <td width="11%" colspan=6 style="border:0;" align="right" >
                           Search by                  
                        </td>
                        <td width="8%" colspan=4 style="border:0;" align="left" >
                             <gw:list  id="idSearch" value="2" styles='width:100%'> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
                        </td>
                        <td width="12%" colspan=6 style="border:0;" align="left" >
                             <gw:textbox id="idtxtTmp" onenterkey   ="OnSearch()" styles='width:95%'/>
                        </td>
                        <td width="10%" colspan=5 style="border:1;" align="right" > Period Month </td>
                        <td width="8%" colspan=4 style="border:1;" align="left" >
                            <gw:datebox id="dtMonth" lang="<%=Session("Lang")%>" styles="width:90%"  type=month></gw:datebox>
                        </td>
                        <td width="4%" colspan=2 style="border:1;" align="right" >  </td>
                        
                        <td width="4%" colspan=2 style="border:1;" align="center" > 
                            
                         </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle"><b>Status</b></td>
					    <td  style="border:0" colspan=7 width="14%" >
					       <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
				        </td>
                        
                        <td width="4%" colspan=2 style="border:0;" align="right" >
                         
                        </td>
                        <td colspan=4 width="8%" style="border:0" align="left">
                            <gw:label id="idRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" />
                        </td>
                         <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report"  onclick="OnPrint(2)"/>
                        </td>
                        
                    </tr>
                    <tr id="tr4" style="border:0;width:100%;height:5%" valign="center" >
                        <td width="12%" colspan=6 style="border:0;" align="right" >
                           Excel File                  
                        </td>
                        <td width="20%" colspan=10 style="border:0;" align="left" >
                            <input id="inputfile" type="file" size="60"  accept="application/msexcel"  >
                        </td>
                        <td width="2%"  style="border:1;" align="right" >
                            <gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnPrint(1)" />
                        </td>
                         <td width="2%"  style="border:1;" align="right" >
                            
                        </td>
                         <td width="2%"  style="border:1;" align="right" >
                            <gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell"  onclick="OnLoadExcel()"/>
                        </td>
                        <td width="2%"  style="border:1;" align="right" >  </td>
                        <td width="2%"  style="border:1;" align="right" >
                            
                        </td>
                        <td width="8%" colspan=4 style="border:1;" align="right" >
                           
                        </td>
                        <td width="4%" colspan=2 style="border:1;" align="right" >  </td>
                        
                        
                        <td  style="border:0"  width="14%" colspan=7 align="right" valign="middle">
                            Increase in Month
                        </td>
					    <td  style="border:0" colspan=7 width="14%" >
					       <gw:list  id="lstIncSal" value="ALL" styles='width:100%'> 
							        <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
					        </gw:list>
				        </td>
                        
                        <td width="4%" colspan=2 style="border:0;" align="right" >
                         
                        </td>
                        <td colspan=4 width="8%" style="border:0" align="left">
                            
                        </td>
                         <td width="2%" style="border:0;" align="right" >
                         
                        </td>
                        
                    </tr>
                    <tr id="tr5" style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=50  style="width:100%;height:100%;"> 
                              <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:100%" valign="top">
                                    <td>
                                     <gw:grid   
                                        id="grdEval"  
                                        header="Factory|Department|Group|Position|Emp ID|Full Name|Join Date|Left Date|Previous Result|Education|Eval Month|Inc Sal Month|Result|Reason|Result|Reason|Issues Date|Old Salary|Increase Amt|New Salary|Import|Remark|_PK|_IMP_SEQ"
                                        format='0|0|0|0|0|0|4|0|0|0|0|0|2|0|2|0|4|1|1|1|0|0|0|0' 
                                        aligns='0|0|0|0|1|0|1|1|0|0|1|1|0|0|0|0|0|0|0|0|1|0|0|0'
                                        defaults='|||||||||||||||||||||||' 
                                        editcol='0|0|0|0|0|0|0|0|0|0|1|0|1|1|1|1|1|0|0|0|0|1|0|0' 
                                        widths='2500|2000|2000|1500|1500|2500|1200|1200|1500|2000|1500|1500|1000|1500|1000|1500|1200|1500|1500|1500|1000|2000|0|0'
                                        sorting='T' 
                                        styles='width:100%; height:100%' />
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
    <gw:textbox id="iduser_pk" styles="display:none" />
    <gw:textbox id="txtFrom" styles="display:none" />
    <gw:textbox id="txtTo" styles="display:none" />
    <gw:textbox id="txtData_YN" styles="display:none" />
    <gw:textbox id="txtFlag_Eval" styles="display:none" />
    <gw:textbox id="txtImp_YN" styles="display:none" />
    <gw:textbox id="txtTmp" styles="display:none" />
    <gw:textbox id="txtImp_Seq" styles="display:none" />
    <!------------------------------------------->
</body>
</html>
