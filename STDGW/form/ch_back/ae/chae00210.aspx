<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var dept,grp,flag=0;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
	<%=ESysLib.SetGridColumnComboFormat( "idGrid" , 11 , "Select v.code, v.code_nm from vhr_hr_code v where v.id='HR0010' ")%>;        
	<%=ESysLib.SetGridColumnComboFormat( "idGrid" , 12 , "Select v.code, v.code_nm from vhr_hr_code v where v.id='HR0008' ")%>;        
	<%=ESysLib.SetGridColumnComboFormat( "idGrid" , 15 , " select 1,'Edit' from dual union all select 2,'Change' from dual  ")%>;     
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";    
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); /**/
    
}
function OnDataReceive(obj)
{
       if (obj.id=="datDeptData")
       {
            if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstOrg.SetDataText(txtDeptData.text)    ;
            
              obj=lstOrg.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;            
       }       
       else if (obj.id=="datUser_info")
       {        
       }
       else if (obj.id=="datEmpBand_Reg")
       {
            if(option_P[0].checked==true)
           onClickOption("1");
           else
           onClickOption("2");
           auto_resize_column(idGrid,0,idGrid.cols-1,0);   
       }
      
       

}      
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
        //txtUpperDept.text=obj;
        //datDeptData.Call();
    }    
}
function OnSearch()
{
    datEmpBand_Reg.Call("SELECT");
}

 //-----------------------------------------------

function OnSetToGrid1()
{       
    ctrl=idGrid.GetGridControl();         
    if(idGrid.rows>=1)
    {  
         if (ctrl.SelectedRows>=1) 
         {
               for(var i=0;i<ctrl.SelectedRows;i++)
               {if(idGrid.GetGridData(ctrl.SelectedRow(i),14)=="")
                {
                    if(lstBand.value!="-1")
                        idGrid.SetGridText(ctrl.SelectedRow(i),4,lstBand.GetText());
                    if (lstGrade.value!="0")                       
                        idGrid.SetGridText(ctrl.SelectedRow(i),5,lstGrade.GetText());
                    idGrid.SetGridText(ctrl.SelectedRow(i),6,idSetDt1.value);
                    if(lstBand.value!="-1")
                        idGrid.SetGridText(ctrl.SelectedRow(i),7,lstBand.value);
                    if (lstGrade.value!="0")    
                        idGrid.SetGridText(ctrl.SelectedRow(i),8,lstGrade.value);
                    idGrid.SetRowStatus(ctrl.SelectedRow(i),16);
                 }   
               }
         }             
     }
}

function OnSetToGrid2()
{
	ctrl=idGrid.GetGridControl();         
    if(idGrid.rows>=1)
    {  
         if (ctrl.SelectedRows>=1) 
         {
               for(var i=0;i<ctrl.SelectedRows;i++)
               {  if(idGrid.GetGridData(ctrl.SelectedRow(i),14)=="")
                    {
					if(lstJobClass.value!="")
						idGrid.SetGridText(ctrl.SelectedRow(i),11,lstJobClass.value);
					if(lstJobTitle.value!="")
					    idGrid.SetGridText(ctrl.SelectedRow(i),12,lstJobTitle.value);
					
					idGrid.SetGridText(ctrl.SelectedRow(i),13,idSetDt2.value);	
                     idGrid.SetRowStatus(ctrl.SelectedRow(i),16);
                    }
               }
         }             
     }
}
function OnSave()
{
    for(var i=1;i<idGrid.rows;i++)
    {
        //alert(idGrid.GetRowStatus(i));
        if(idGrid.GetRowStatus(i)==16 && idGrid.GetGridData(i,14)=="")
        {
            if(idGrid.GetGridData(i,7)=="-1" || idGrid.GetGridData(i,8)=="0"|| idGrid.GetGridData(i,8)=="")
            {
                alert("Cannot update blank Band or Grade at row: " + i);
                return;
            }
            if(idGrid.GetGridData(i,6)=="" ||  idGrid.GetGridData(i,13)=="")
            {
                alert("Cannot update blank Date at row: " + i);
                return;
            }
			if(idGrid.GetGridData(i,11)=="" ||  idGrid.GetGridData(i,12)=="")
            {
                alert("Cannot update blank Job Class or Job Title at row: " + i);
                return;
            }
        }  /**/  
    }
    datEmpBand_Reg.Call();
}

function OnReport()
{var url='';  
if(lstReport.value=='1')
    {url=System.RootURL + '/reports/ch/ae/rpt_job_class.aspx?l_org_type='+lstOrg_type.value+'&l_tco_org_pk='+lstOrg.value+'&l_search_by='+idSearch.value+'&l_search_temp='+idtxtTmp.text+'&l_nation='+lstNation.value+'&l_staus='+lstStatus.value ;              
     url += '&l_user=' + "<%=session("USER_ID")%>";
    }
if(lstReport.value=='2')
    {url=System.RootURL + '/reports/ch/ae/rpt_band_grade.aspx?l_org_type='+lstOrg_type.value+'&l_tco_org_pk='+lstOrg.value+'&l_search_by='+idSearch.value+'&l_search_temp='+idtxtTmp.text+'&l_nation='+lstNation.value+'&l_staus='+lstStatus.value ;              
     url += '&l_user=' + "<%=session("USER_ID")%>";
    }

    window.open(url);    
}
function Del()
{

idGrid.DeleteRow();
}
function OnPopup()
{
    var col=event.col;
    var row=event.row;
    if(col==4 || col==5)
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00210_01.aspx";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:32;dialogHeight:35;dialogLeft:100;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if(obj!=null)
        {
            idGrid.SetGridText(row,4,obj[0]);
            idGrid.SetGridText(row,5,obj[1]);
            idGrid.SetGridText(row,7,obj[2]);
            idGrid.SetGridText(row,8,obj[3]);
        }
    }
}
function OnChangeBand()
{
    //alert(1);
    if (lstBand.value==null || lstBand.value=="-1")
    {
        alert("Please choose Band kind first");
        lstGrade.ClearData();
        return;
    }
    datBand_GradeData.Call();
}
function onClickOption(obj)
{ var count=0; 

for(var i=1; i< idGrid.rows;i++)
 {
 
  if(obj=='1' )
             {
             if(idGrid.GetGridData(i,14)!="") 
                 {idGrid.GetGridControl().RowHidden(i)=1;
                 //idGrid.SetCellBgColor(i, 0,i, 13, 0xff99ff );
                 
                 }
             else
                 {idGrid.GetGridControl().RowHidden(i)=0;
                 //idGrid.SetCellBgColor(i, 0,i, 13,0xFFFFFF  );
                 count++;
                 }
             
            }
if(obj=="2" )
      {
             if(idGrid.GetGridData(i,14)!="") 
                 {idGrid.GetGridControl().RowHidden(i)=0;
                 idGrid.SetCellBgColor(i, 0,i, 13, 0xff99ff );
                 
                 }
             else
                 {idGrid.GetGridControl().RowHidden(i)=0;
                // idGrid.SetCellBgColor(i, 0,i, 13,0xFFFFFF );
                 }
      }
                        
 
 }
 
         if(obj=="2")
        {count=idGrid.rows-1;
         var fg=idGrid.GetGridControl(); 	  
             fg.MergeCells =3	;
            fg.MergeCol(0) =true	;
            fg.MergeCol(1) =true	;
            fg.MergeCol(2) =true	;
            fg.MergeCol(3) =true	;
           
        }
        else
        {var fg=idGrid.GetGridControl(); 	  
             fg.MergeCells =0	;
        }
       idRecord.text=count + " Records.";
}
</script>

<body>
<!------------main control---------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datEmpBand_Reg" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="6,7,8,9,11,12,13,14,15" function="HR.sp_sel_band_grade" procedure="HR.SP_UPD_BAND_GRADE"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstOrg_type" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />                    
					<input bind="lstStatus" />  
					
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datBand_GradeData" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="HR.SP_LIST_BAND_GRADE" > 
            <input> 
                <input bind="lstBand" />
            </input>
	       <output>
	            <output bind="lstGrade" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
<!--------------------main table--------------------------------->

<table name="Current" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:18%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	            <tr style="height:6%;border:0">	
		            <td align=right colspan=4 style="width:8%" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		            <td align=right colspan=10 style="width:20%"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM COMM.TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                            </data>
                        </gw:list>
                    </td>
		            <td align=right colspan=3 style="width:6%">Org Type</td>
		            <td align=right colspan=6 style="width:12%">
		                <gw:list  id="lstOrg_type" value="ALL" maxlen = "100" styles='width:100%'>
                         <data><%=Esyslib.SetListDataFUNC("SELECT comm.F_COMMONCODE('COEO0030','','') FROM DUAL" )%>|ALL|Select All</data></gw:list>
                    </td>
                    <td align=right colspan=3 style="width:10%">Search by</td>
		            <td align=left colspan=4 style="width:10%"><gw:list  id="idSearch" value="1" styles="width:98%" onChange="">
                                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td align=right colspan=4 style="width:10%"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>
		            <td align=right  colspan=2 style="width:12%; white-space:nowrap"> 
		                <table style="width:100%; height:100%">
		                <tr> <td style="width:80%;">
		                <gw:list id="lstReport" value="1"  maxlen = "100" styles='width:100%' >
                        <data>
                            LIST|1|Report Job Titile|2|Report Band-Grade
                        </data>
                        </gw:list>
		                </td>
		                <td style="width:20%"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		                </tr>
		                </table>
		            
                        
		            </td>
		            
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnDel" alt="Delete history" img="Delete" text="Delete" onclick="Del()" /></td>
   
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>		            		                            		                                                    		            		            		      
				</tr>
				<tr style="height:6%;border:0">	
					<td align=right colspan=14 style="width:8%" >View Current <input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" / ></td>
		            <td align=right colspan=9 >View History <input type="radio" name="option_P" value="2"  onclick="onClickOption(2)" /></td>
		            
                    <td align=right colspan=3 style="width:6%">Nation</td>
		            <td align=left colspan=8 >
					<gw:list id="lstNation" value="01"  maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                        </data>
                        </gw:list>
					</td>
					<td align=right colspan=1 style="width:6%">Status</td>
					<td align=right colspan=1 style="width:6%">
						<gw:list id="lstStatus" value="A"  maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0022'")%>|ALL|Select All
                        </data>
                        </gw:list></td>		            		            
		            <td align=right colspan=3  >
						<b><gw:label id="idRecord" text="0 rec(s)" styles="width:100%;color:Red;" ></gw:label></b>
                    </td>                                        		            		                         
				</tr>
                <tr style="height:6%;border:0">	
		            <td align=right colspan=4>Band-Grade</td>
		            <td align=left colspan=5>
					<gw:list  id="lstBand" value="-1" maxlen="100" styles='width:100%' onchange="OnChangeBand()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VHR_HR_CODE V WHERE V.ID='HR0109' ORDER BY V.CODE_NM ")%>|-1|
                            </data>
                        </gw:list>
					</td>
		            <td align=right colspan=5>
					<gw:list  id="lstGrade" value="" maxlen = "100" styles='width:100%' onchange="" >
                            <data>|0|                                
                            </data>
                        </gw:list>
					</td>
		            <td align=right colspan=3 >Set Date</td>
		            <td align=right colspan=4>
						<gw:datebox id="idSetDt1" nullaccept maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />
					</td>
		            <td align=right colspan=2>
		                <gw:imgBtn id="ibtnSet1" alt="Set Grid" img="set" text="" onclick="OnSetToGrid1()" />
		            </td>
		            <td align=right colspan=3>Class-Title</td>
		            <td align=right colspan=4>
		             <!-- band cu~ -->
						<gw:list id="lstJobClass" maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("Select v.code, v.code_nm from vhr_hr_code v where v.id='HR0010' ")%>
                        </data>
                        </gw:list>
		            </td>
		            <td align=right colspan=4 >
						<gw:list id="lstJobTitle" maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("Select v.code, v.code_nm from vhr_hr_code v where v.id='HR0008' ")%>
                        </data>
                        </gw:list>
		             <!-- grade cu~ -->   
                    </td>
                   
                    
		            <td align=right colspan=1>Set Date</td>
		            <td align=left colspan=2>
					<gw:datebox id="idSetDt2" nullaccept maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />
					</td>
					<td align=right colspan=2 >
						<gw:imgBtn id="ibtnSet2" alt="Set Grid" img="set" text="" onclick="OnSetToGrid2()" />
					</td>
		            
                </tr>	                                
	        </table>
	        <table id="tblMain" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="Organization|_Org Type|Emp ID|Full Name|Band|Grade|Band Date|_Band Code|_Grade Code|_Emp_pk|_Pos Date|Job Class|Job Title|Job Date|_p_pk|Flag"   
				        format="0|0|0|0|0|0|4|0|0|0|4|1|1|4|0|0"  
				        aligns="2|0|1|0|1|1|1|1|1|0|1|2|2|1|0|0"  
				        defaults="|||||||||||||||"  
				        editcol="0|0|0|0|0|0|1|0|0|0|1|1|1|1|0|0"  
				        widths="2500|0|1000|2500|1400|1400|1400|0|0|0|0|1400|1400|1400|0|1000"  
				        styles="width:100%; height:100% "   
				        sorting="F"   
				        acceptNullDate
				        oncelldblclick="OnPopup()"
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>


   <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
</body>
</html>
