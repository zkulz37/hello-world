<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var v_language = "<%=Session("SESSION_LANG")%>";
var user='';

function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user="<%=session("USER_ID")%>";
    
    grdDetail.SetComboFormat(13,"<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0017'  union  all select 'ALL','Select ALL' from dual  ")%>");
     grdDetail.SetComboFormat(14,"<%=ESysLib.SetGridColumnDataSQL("select to_char(pk),org_nm from tco_org where del_if=0  union  all select 'ALL','Select ALL' from dual  ")%>");
    grdDetail2.SetComboFormat(3,"<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0001' order by a.code  ")%>");
	
    grdDetail2.SetComboFormat(4,"#Y;Only Pay|#N;No Pay|#U;Unused ");
    grdBonusAMT.SetComboFormat(13,"#Y;Yes|#N;No");
   grdBonusAMT.GetGridControl().FrozenCols =4;
   grdBonusAMT.GetGridControl().ScrollTrack=true;
      
    dtTo_P.SetEnable(0);
		
      if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
	{datUser_info2.Call();
	}
}
function ChangeLocation()
{datUser_info2.Call("SELECT");    
}  
//-------------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg_Code.value=obj;
             
        }
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
}
//----------------------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);

}
//------------------------------------------------------------------------------------

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
function Active_Button(obj)
{   if(active_page==0||active_page==-1)
    {idStatus.text=(txtClose.text=='0')? 'Status: Open':(txtClose.text=='1')?'Status: Close.':'Status: Undefine' ;   
    if(obj=='1')
        {idAdd.SetEnable(0);
        idDel.SetEnable(0);idUnDel.SetEnable(0);
        idSave.SetEnable(0);idSave2.SetEnable(0);
        dtTo.SetEnable(0);
        btClose.SetEnable(1);
        btClose.text=' Open '; 
        }
        else 
        if(obj=='-1')
        {dtTo.SetEnable(1); idAdd.SetEnable(0);
        idDel.SetEnable(0);idUnDel.SetEnable(0);
        idSave.SetEnable(0);idSave2.SetEnable(1);
        btClose.SetEnable(0);
        btClose.text='Undefine';
        }
        else
        {dtTo.SetEnable(1);
        idAdd.SetEnable(1);
        idDel.SetEnable(1);idUnDel.SetEnable(1);
        idSave.SetEnable(1);idSave2.SetEnable(1);
          btClose.SetEnable(1);
        btClose.text=' Close ';
        }
         
    }  
    else
    {  if(obj=='1')
            {ibtnSave_B.SetEnable(0);btProcess.SetEnable(0);btDelete.SetEnable(0);}
       else if(obj=='-1')
            {btProcess.SetEnable(0);btDelete.SetEnable(0);ibtnSave_B.SetEnable(0);}
        else {ibtnSave_B.SetEnable(1);btProcess.SetEnable(1);btDelete.SetEnable(1);}   
    }
    

	
}
//----------------------------------------------
function OnDataReceive(obj)
{ 
	if (obj.id=="datUser_info")
        {   
		lstCompany.SetDataText(txt_temp.text);
		lstCompany2.SetDataText(txt_temp.text);
		
			active_page=-1;
			datUser_info2.Call(); 
        }
	if (obj.id=="datUser_info2")
        { // alert(txt_temp.text + " >>"+ active_page);
           if(active_page==1)
		     {lstOrg_Code.SetDataText(txt_temp.text);
			   	datCheckClose.Call();	
			 }
			if(active_page==0||active_page==-1)
		     {  if(active_page==-1)
					lstOrg_Code.SetDataText(txt_temp.text);
			 
					 var arr = txt_temp.text.replace("DATA|",'').split("|");
				   var s="";
				   //alert(arr);
				   var t=0;
					   for(var i=0;i< (arr.length+1)/2-1;i++)
						{
							s = s +"#" + arr[t] + ";" + arr[t+1]+"|";
							t=t+2;
							//alert(s);
						}
					    //alert(s);
						grdDetail.SetComboFormat(14,s  );
					 datSelectBonusMaster.Call();
			   		
			 } 
        }	
  if(obj.id=='datCheckClose')
    Active_Button(txtClose.text);
  if(obj.id=='datBonusDetail')
    {auto_resize_column(grdDetail,0,grdDetail.cols-1,0);    
    for(var i=1;i<= grdDetail.rows-1;i++)
  grdDetail.SetCellBgColor(i,9,i,12,0xFFCC00);
      
    }
  if(obj.id=='datUpdateBonusMaster')
  { datSelectBonusMaster.Call();
  }   
  if(obj.id=='datSelectBonusMaster') 
  {
    if(grdDetail2.rows==1)
      {
      grdDetail2.AddRow();
      grdDetail2.AddRow();
      grdDetail2.AddRow();
      }
      grdDetail2.SetGridText(1,0,'Join Date');
      grdDetail2.SetGridText(1,1,txtFromJ.text);
      grdDetail2.SetGridText(1,2,txtToJ.text);
      grdDetail2.SetGridText(1,4,txtOptionJ.text);
      grdDetail2.SetGridText(2,0,'Left Date');
      grdDetail2.SetGridText(2,1,txtFromL.text);
      grdDetail2.SetGridText(2,2,txtToL.text);
      grdDetail2.SetGridText(2,4,txtOptionL.text);
      grdDetail2.SetGridText(3,0,'Contract Type');
      grdDetail2.SetGridText(3,3,txtContractType.text);
      grdDetail2.SetGridText(3,4,txtOptionC.text);
      grdDetail2.SetCellBgColor(1,3,1,3,0x0000FF);
      grdDetail2.SetCellBgColor(2,3,2,3,0x0000FF);
      grdDetail2.SetCellBgColor(3,1,3,2,0x0000FF);
      Active_Button(txtClose.text);
     datBonusDetail.Call('SELECT');
     
  }
  if(obj.id=='datClose')
    Active_Button(txtClose.text);
  if(obj.id=='datProcess')
  { clear_Interval(idInterval);
    if(txtResult.text=='1')
    alert("Bonus processing completed!\nQuá trình tính thưởng hoàn tất!")
    else
    alert("Bonus processing met error!Please contact with admin \nQuá trình tính thưởng đã gặp lỗi!Vui lòng liên hệ admin!")
  }
  if(obj.id=='datUnProcess')
  { if(txtResult.text=='1')
    alert("Delete bonus completed!\nQuá trình xóa bảng thưởng hoàn tất!")
    else
    alert("Delete bonus met error!Please contact with admin \nQuá trình xóa đã gặp lỗi!Vui lòng liên hệ admin!")
  }  
 if(obj.id=='datBonusAMT')
    {auto_resize_column(grdBonusAMT,0,grdBonusAMT.cols-1,0);  
    for(var i=1;i<= grdBonusAMT.rows-1;i++)
  grdBonusAMT.SetCellBgColor(i,11,i,12,0xFFCC00);
      
    idRecord.text=grdBonusAMT.rows-1+'( rec)'
    }
 if(obj.id=='datFind_Report')    
  {    var url =System.RootURL + '/reports/ch/cs/' 
 + txtReport_tmp.text + '?l_tco_org=' + lstOrg_Code.value  +
                         '&l_wgroup=' + lstWorkGroup.value + 
                         '&l_year=' + dtYear_P.value + 
                         '&l_bn_times=' + lstTimes_P.value +
                         '&l_emp_type=' + lstEmp_Type.value +
                         '&l_nation=' + lstNation.value +
                         '&l_contract=' + lstContract_Type.value +
                         '&l_search=' + lstTemp.value +
                         '&l_Temp=' + txtTemp.text +
                         '&l_j_from=' + dtJoinFrom.value +
                         '&l_j_to=' + dtJoinTo.value +
                         '&l_l_from=' + dtLeftFrom.value +
                         '&l_l_to=' + dtLeftTo.value +
                         '&l_Senority_from=' + txtSenForm.text +
                         '&l_Senority_to=' + txtSenTo.text +
                         '&l_type=' + lstType.value                 
                         ;
 window.open(url);
 }
  
    
  
}
//------------------------------------------------
function OnChangeDept(deptobj)
{
   
}
//------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------
function OnReport()
{
   txtReport_tmp.text='rpt_bonus_amt.aspx';
   datFind_Report.Call();
}

//-----------------------------------------------
function OnSearch()
{datBonusAMT.Call('SELECT');
}

//-----------------------------------------------------
function OnSave(obj)
{
if(obj=='1'&& OnCheck(1)==1)
  return; 
if(obj=='2'&& (lstOption.value=='1'||lstOption.value=='2') && dtMonth.value=='')
{alert("Please input month salary you want to include bonus amount!\n Vui lòng nhập vào tháng lương mà bạn muốn đưa tiền thưởng vào tính ");
return;
}
if(confirm("Do you want to save? \n Bạn có muốn lưu lại không?") )
        {if(obj=='1')
         {   
                datBonusDetail.Call();
         }
        if(obj=='2')
        {
        
      txtFromJ.text= grdDetail2.GetGridData(1,1);
      txtToJ.text= grdDetail2.GetGridData(1,2);
      txtOptionJ.text=grdDetail2.GetGridData(1,4);
      
      txtFromL.text=grdDetail2.GetGridData(2,1);
      txtToL.text=grdDetail2.GetGridData(2,2);
      txtOptionL.text=grdDetail2.GetGridData(2,4);
           
      txtContractType.text=grdDetail2.GetGridData(3,3);
      txtOptionC.text=grdDetail2.GetGridData(3,4);
      
          datUpdateBonusMaster.Call();
        }
        if(obj=='3')
        {   datBonusAMT.Call();
        }
    }
}
//-----------------------------------------------------
function OnOption(option,obj,vdtMonth,vlstQuarter,vdtYear,vdtFromDate,vdtToDate)
{
}
//----------------------------------------
function ShowDetail(grd_obj,emp_pk_obj)
{
}
//----------------------------------
function OnCal_ALL()
{
}
//----------------------------------
var active_page=-1;
function onPage_active()
{ if(active_page==1)
    {active_page=0;
    }
  else
  if(active_page==0)
    {active_page=1;
    }
    
    if(active_page==-1)
    {active_page=1;
    datCheckClose.Call();
    }
   
   
    
}
//------------------------------------
function OnCal_Break_Contract()
{
 
}

function OnSetGrid()
{   var ctrl,i
	ctrl=grdBonusAMT.GetGridControl();
	if(ctrl.SelectedRows>0 )
		for(i=0;i<ctrl.SelectedRows;i++)
    		grdBonusAMT.SetGridText(ctrl.SelectedRow(i),12,txtAmount.text);    
}

function OnChangeTimes()
{   if(active_page==0||active_page==-1)
   { 
   datSelectBonusMaster.Call();
   }
    else
    datCheckClose.Call();
}

function OnAdd()
{grdDetail.AddRow();
//alert (grdDetail.rows);
var tmp=txtBonusMasterPK.text ;//dtYear.value;
//alert(tmp);
grdDetail.SetGridText(grdDetail.rows-1,1,tmp);
tmp=lstTimes.value;
grdDetail.SetGridText(grdDetail.rows-1,2,tmp);
 grdDetail.SetCellBgColor(grdDetail.rows-1,9,grdDetail.rows-1,12,0xFFCC00);
}

function OnDelete(obj)
{if(confirm("Do you want to delete?\nBạn đã chắc chắn delete?"))    
     {if(obj==1)
         grdDetail.DeleteRow();
     else
        datUnProcess.Call();
      }  
}
function OnUnDelete()
{
    grdDetail.UnDeleteRow();
}

function OnProcess()
{
    if(confirm('Do you want to process bonus?\nBạn có muốn bắt dầu quá trình tính thưởng không !'))
    {set_Interval(100); 
    datProcess.Call();
    }
}
//---------------------------------------
function OnCheck(obj)
{
 if(obj==1)
    {for(var i=1;i<= grdDetail.rows-1;i++)
        {
          if( (Number(grdDetail.GetGridData(i,4)) > Number( grdDetail.GetGridData(i,5))&&  grdDetail.GetGridData(i,5)!='')   ||( grdDetail.GetGridData(i,4)=='' &&  grdDetail.GetGridData(i,5)=='')   || Number(grdDetail.GetGridData(i,4))<0 || Number( grdDetail.GetGridData(i,5))< 0  )        
                {  alert("You input incorrect data in From ,To column at Row "+i +".\nBạn nhập dữ liệu không đúng ở cột From, To  ")
                    grdDetail.SetGridText(i,4,'');grdDetail.SetGridText(i,5,'');                
                return 1;
                }
            if((grdDetail.GetGridData(i,6)!='' && grdDetail.GetGridData(i,7)!='')||(grdDetail.GetGridData(i,6)=='' && grdDetail.GetGridData(i,7)=='') ) 
                {alert("You choose Month Salary or Amount at Row "+i +".\nBạn chỉ được chọn lương tháng hoặc nhập giá trị thưởng khác")
                grdDetail.SetGridText(i,7,'');        
                return 1;
                }
          
            if( grdDetail.GetGridData(i,9)=='-1' && (Number(grdDetail.GetGridData(i,10))< 0 || grdDetail.GetGridData(i,10)=='') ) 
                {alert("You must input Divisor greater than zero at row "+i +".\nBạn phải nhập số chia lớn hơn 0 ở cộ Divisor!")
                grdDetail.SetGridText(i,10,'');        
                return 1;
                }
            if( grdDetail.GetGridData(i,9)!='-1' && (grdDetail.GetGridData(i,11)!=''||grdDetail.GetGridData(i,10)!=''||grdDetail.GetGridData(i,12)!='') )
            {alert ("You must input null at Min, Max amount and Divisor column at row "+i +" when you don't use Seniority Ratio.\nBạn phải để trống các cột Min, Max amount và Divisor khi bạn không sử dụng cách tính theo tỉ lệ!")
             grdDetail.SetGridText(i,11,''); 
             grdDetail.SetGridText(i,12,'');
             grdDetail.SetGridText(i,10,'');                       
             return 1;   
            } 
            if( grdDetail.GetGridData(i,9)=='-1' ) 
                {  if(grdDetail.GetGridData(i,11)!='' && Number(grdDetail.GetGridData(i,11))< 0 )
                       { alert("You must input numberic or null at Min amount column at row "+i +".\nBạn phải nhập số hoặc để trống ở cột Min Amount!")
                                grdDetail.SetGridText(i,11,'');        
                        return 1;
                        }
                  if(grdDetail.GetGridData(i,12)!='' && Number(grdDetail.GetGridData(i,12))< 0 )
                       { alert("You must input numberic or null at  Max Amount colunm at row "+i +".\nBạn phải nhập số hoặc để trống ở cột Max Amount!")
                                grdDetail.SetGridText(i,12,'');        
                        return 1;
                        }
                  if(grdDetail.GetGridData(i,12)!=''&& grdDetail.GetGridData(i,11)!='' &&  (Number(grdDetail.GetGridData(i,11))> Number(grdDetail.GetGridData(i,12))))          
                        { alert("You must input numberic at Max Amount greater than Min Amount at row "+i +".\nBạn phải nhập Max Amount lớn hơn Min Amount hoặc để trống!")
                                grdDetail.SetGridText(i,12,'');        
                        return 1;
                        }
                        
                
                }        
        }
     }
 if(obj==2)
   {
   if(grdDetail2.GetGridData(grdDetail2.row,4)=='U' && grdDetail2.row==1)
        {       
           grdDetail2.SetGridText(1,1,'');grdDetail2.SetGridText(1,2,'');
        }
      if(grdDetail2.GetGridData(grdDetail2.row,4)=='U' && grdDetail2.row==2)
        {grdDetail2.SetGridText(2,1,'');grdDetail2.SetGridText(2,2,'');
        }
     if(grdDetail2.GetGridData(grdDetail2.row,4)=='U' && grdDetail2.row==3)
        {grdDetail2.SetGridText(3,3,'');
        }     
        grdDetail2.SetGridText(1,3,'');
        grdDetail2.SetGridText(2,3,'');
        grdDetail2.SetGridText(3,2,'');grdDetail2.SetGridText(3,1,'');
    return 1;            
   }
    
      return 0;  
}
function OnChangeDate()
{
   
    
}
function OnClose()
{    if(confirm('Do you want to close bonus formular?\nBạn có muốn đóng công thức thưởng không!'))
        datClose.Call();
        
}
function OnChangOption()
{if((lstOption.value=='1'||lstOption.value=='2') && dtMonth.value=='')
    alert("Please input month salary you want to include bonus amount!\n Vui lòng nhập vào tháng lương mà bạn muốn đưa tiền thưởng vào tính ");

if(lstOption.value=='3')
    {dtMonth.value='';//dtMonth.text='';
    
    }
    

}


function OnDeleteDetail()
{
    if(confirm("Do you want to delete?" + "\n" + "Bạn có muốn xóa không?"))
    {
        grdBonusAMT.DeleteRow();
    }
}


</script>
<body >




<!----------------------------------------------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_get_company_user"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------------------------------->
<gw:data id="datSelectBonusMaster" onreceive="OnDataReceive(this)"  > 
        <xml> 
              <dso  type="process" procedure="hr_sel_10030016_bonus_master" > 
                <input>
                    <input bind="dtYear" />
                    <input bind="lstTimes" />                                       
					<input bind="lstCompany" />                                       
                </input> 
                <output>
                    
					
					<output bind="txtBonusMasterPK" />
                    <output bind="txtRemark" />
                    <output bind="dtTo" />
                    <output bind="lstUnit" />
                    <output bind="lstOption" />
                    <output bind="dtMonth" />
                    <output bind="txtOptionJ" />
                    <output bind="txtFromJ" />
                    <output bind="txtToJ" />
                    <output bind="txtOptionL" />
                    <output bind="txtFromL" />
                    <output bind="txtToL" />
                    <output bind="txtOptionC" />
                    <output bind="txtContractType" />
                    <output bind="txtClose" />
               </output>
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------------------------------->
<!----------------------------------------------------------->
<gw:data id="datUpdateBonusMaster" onreceive="OnDataReceive(this)" > 
        <xml> 
              <dso  type="process" procedure="hr_upd_10030016_bonus_master" > 
                <input>
                    <input bind="dtYear" />
                    <input bind="lstTimes" />
					<input bind="lstCompany" />  
                    <input bind="txtBonusMasterPK" />
                    <input bind="txtRemark" />
                    <input bind="dtTo" />
                    <input bind="lstUnit" />
                    <input bind="lstOption" />
                    <input bind="dtMonth" />
                    <input bind="txtOptionJ" />
                    <input bind="txtFromJ" />
                    <input bind="txtToJ" />
                    <input bind="txtOptionL" />
                    <input bind="txtFromL" />
                    <input bind="txtToL" />
                    <input bind="txtOptionC" />
                    <input bind="txtContractType" />
                    
               </input> 
                <output>
                    <output bind="txtClose" />
               </output>
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------------------------------->

<gw:data id="datClose" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030016_close_bonus" > 
                <input>
                   <input bind="dtYear" />
                   <input bind="lstTimes" />
				   <input bind="lstCompany" />  
                   <input bind="txtClose" />
                </input> 
                <output>                    
                    <output bind="txtClose" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCheckClose" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030016_check_bonus" > 
                <input>
                    <input bind="dtYear_P" />
                    <input bind="lstTimes_P" />
					<input bind="lstCompany2" />
                                       
                </input> 
                <output>                    
                    <output bind="txtClose" />
                    <output bind="dtTo_P" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>





<gw:data id="datProcess" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030016_bonus_v2" > 
                <input>
                    <input bind="dtYear_P" />
                    <input bind="lstTimes_P" />
                    <input bind="lstCompany2" />
					<input bind="textExchange" />
					<input bind="dtTo_P" />     
						
				    				
                </input> 
                <output>
                   <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datUnProcess" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030016_delete_bonus" > 
                <input>
                    <input bind="dtYear_P" />
                    <input bind="lstTimes_P" />
                    <input bind="lstCompany2" />
                </input> 
                <output>
                   <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>


<gw:data id="datUser_info2" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datBonusDetail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="hr_sel_10030016_bonus_detail" procedure="hr_upd_10030016_bonus_detail"> 
                <input bind="grdDetail" >
                    <input bind="txtBonusMasterPK" />
                    
                </input>
                <output  bind="grdDEtail" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------>

<gw:data id="datBonusAMT"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,9,11,12,13" function="hr_sel_10030016_bonus_amt" procedure="hr_upd_10030016_bonus_amt"> 
                <input bind="grdBonusAMT" >
                    <input bind="dtYear_P" />
                    <input bind="lstTimes_P" />
                    
                    <input bind="dtTo_P" />
                    <input bind="lstOrg_Code" />
                    <input bind="lstEmp_Type" />
                    <input bind="lstWorkGroup" />
                    <input bind="lstNation" />
                    <input bind="lstContract_Type" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="dtJoinFrom" />
                    <input bind="dtJoinTo" />
                    <input bind="dtLeftFrom" />
                    <input bind="dtLeftTo" />
                    <input bind="lstType" />
                    <input bind="txtSenForm" />
                    <input bind="txtSenTo" />
                </input>
                <output  bind="grdBonusAMT" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>

<!------------------------------------------>
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
<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPage_active()" >
   <table name="Bonus Formula " width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
     <tr style="height:10%; border:0;font-family:Times New Roman">
     <td colspan=1 style="width:10%; border:0; text-align:center">COMPANY</TD>
	 <td colspan=2 style="width:20%; border:0; text-align:center"><gw:list  id="lstCompany"  maxlen = "100" styles='width:70%'onchange="ChangeLocation()"> <data>
                                <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                            </data>
                        </gw:list></TD>
	 
	 <td colspan=7 style="width:70%; border:0; text-align:center"><b style="font-size:xx-large;font-family:Times New Roman">BONUS FORMULA</b> </td>
     </tr>
     <tr style="height:4%; border:0">
     <td colspan=1 style="width:10%; border:0; text-align:right"><b style="font-size:large;font-family:Times New Roman">Year</b> </td>
	 
	 
     <td colspan=1 style="width:10%; border:0; text-align:left"> 
     <gw:datebox styles="width:10%" lang="<%=Session("Lang")%>"  id="dtYear" type="year"  onchange="OnChangeTimes()" /></td>
     
     <td colspan=1 style="width:10%; border:0; text-align:right"><b style="font-size:large;font-family:Times New Roman">Times</b> </td>
     <td colspan=2 style="width:10%; border:0; text-align:left">
        <gw:list  id="lstTimes" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeTimes()" >
								<data>
									<%=ESysLib.SetListDataSQL("select v.code,v.code_nm from vhr_hr_code v where v.id='HR0057' order by v.code ")%>
								</data>
		</gw:list>
      </td>
     <td colspan=1 style="width:10%; border:0; text-align:right"><b style="font-size:large;font-family:Times New Roman">Remark</b> </td>
     <td colspan=2 style="width:10%; border:0; text-align:left"><gw:textbox styles="widh:100%"  lang="<%=Session("Lang")%>"    id="txtRemark" type="date"  /></td>
     <td colspan=1 style="width:10%; border:0; text-align:right"><gw:icon id="btClose" styles="widh:100%"  img="in"  text="  Open  "  onclick="OnClose()"/> </td>
     
     
     </tr>
     <tr  style="height:4%; border:0">
     <td colspan=3 style="width:10%; border:0; text-align:right"><b style="font-size:large;font-family:Times New Roman">Calculate seniority until date</b> </td>
     <td colspan=1 style="width:10%; border:0; text-align:left"><gw:datebox styles="widh:100%"  lang="<%=Session("Lang")%>"  nullaccept  id="dtTo" type="date"  onchange="OnChangeDate()" /></td>
     <td colspan=1 style="width:10%; border:0; text-align:left"><b style="font-size:large;font-family:Times New Roman">Use Unit</b></td>
     <td colspan=2 style="width:10%; border:0; text-align:left">
     <gw:list  id="lstUnit" value='2' maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                |1|Day|2|Month|3|Year
                            </data>
                            </gw:list>
     </td>
     <td colspan=2 style="width:10%; border:0; text-align:left">
     <gw:list  id="lstOption" value='2' maxlen = "100" styles='width:100%' onchange="OnChangOption()" >
                            <data>
                                |1|Include month salary|2|Calculate income tax |0|
                            </data>
                            </gw:list>
     </td>
     <td colspan=1 style="width:10%; border:0; text-align:left"><gw:datebox styles="widh:100%"  lang="<%=Session("Lang")%>"  nullaccept  id="dtMonth" type="month"  onchange="" /></td>                       
     </tr>
     
     
      <tr style="height:4%;border:0">
     <td colspan=9 style="width:82%;border:0" align=left><gw:label id="idStatus" text="" styles="width:100%;color:red;font-size:large;" ></gw:label> </td>
     <td    align=right style=" border:0;width:2%;white-space:nowrap"><gw:imgBtn img="save" id="idSave2"    alt="save"  onclick="OnSave(2)"/>
      </td>
     
     </tr>
     <tr style="height:20%;border:0">
       <td colspan=10>
       <gw:grid id="grdDetail2" 
					        header="Condition Name|From date|To date|Contract  type|Option" 
					        format="0|4|4|0|0" 
					        aligns="0|1|1|1|1" 
					        defaults="||||" 
					        editcol="1|1|1|1|1" 
					        widths="2000|2000|2000|2000|2000" 
					        styles="width:100%; height:100%" 
					        sorting="F" acceptNullDate 
					        onafteredit="OnCheck(2)" />			                         
     </td>
     
     </tr>
    
     <tr style="height:4%;border:0">
     <td colspan=10 style="width:100%;border:0">
        <table>
            <tr>
                <td style="width:82%;border:0" align=left></td>
                <td colspan=1  align=right style="width:2%;border:0" ><gw:imgBtn img="new" id="idAdd"    alt="Add new Range"  onclick="OnAdd()"/></td>    
                <td colspan=1  align=right style="width:2%;border:0" ><gw:imgBtn img="delete" id="idDel"    alt="Delete"  onclick="OnDelete('1')"/></td>
                <td colspan=1  align=right style="width:2%;border:0" ><gw:imgBtn img="UDelete" id="idUnDel"    alt="Undelete"  onclick="OnUnDelete()"/></td>    
                <td colspan=1   align=left style=" border:0;width:2%;white-space:nowrap"><gw:imgBtn img="save" id="idSave"    alt="save"  onclick="OnSave(1)"/></td>     
            </tr>
        </table>
     </td>
        </tr>
     <tr style="height:41%;border:0">
       <td colspan=10>
       <gw:grid id="grdDetail" 
					        header="_pk|_p_master_pk|_times|Seq|From(>)|To(<=)|Month Salary|Amount|Rate|Seniority Ratio|Divisor|Min Amount|Max Amount|Employee Type|Organization" 
					        format="0|0|0|0|1|1|2|1|1|3|1|1|1|0|0" 
					        aligns="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1" 
					        defaults="||||||||||||||" 
					        editcol="0|0|0|1|1|1|1|1|1|1|1|1|1|1|1" 
					        widths="1500|0|0|1000|2000|2000|1500|1000|2000|2000|2000|2000|2000|2000|2000" 
					        styles="width:100%; height:100%" 
					        sorting="T" acceptNullDate 
					       onafteredit="" />				                         
     </td>
             
     </tr>
     
    </table>
    <table name="Process Bonus"  width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table style="width:100%;height:100%" id="Table1" style="height:15%" border=0 cellpadding="0" cellspacing="0">
					<tr width="100%">
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					</tr>
                     <tr style="height:5%; border:0">
                         <td colspan=1 align=right style="width:3%; border:0; text-align:right">Company</TD>
					<td colspan=15 style="width:15%; border:0; text-align:right"/>
					<gw:list  id="lstCompany2" onchange="ChangeLocation()"  maxlen ="100" >
					<data>
                                <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                            </data>
                        </gw:list></TD>
	
						 <td colspan=2 style="width:3%; border:0; text-align:right"><b style="font-size:large;font-family:Times New Roman;color:Red">Year</b> </td>
                         <td colspan=5 style="width:10%; border:0; text-align:left"> 
                         <gw:datebox styles="width:10%" lang="<%=Session("Lang")%>"  id="dtYear_P" type="year"  onchange="OnChangeTimes()" /></td>
                         
                         <td colspan=5 style="width:10%; border:0; text-align:right"><b style="font-size:large;font-family:Times New Roman;color:Red">Times</b> </td>
                         <td colspan=15 style="width:10%; border:0; text-align:left">
                            <gw:list  id="lstTimes_P" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeTimes()" >
								                    <data>
									                    <%=ESysLib.SetListDataSQL("select v.code,v.code_nm from vhr_hr_code v where v.id='HR0057' order by v.code ")%>
								                    </data>
		                    </gw:list>
                          </td>
                         <td colspan=20 style="width:10%; border:0; text-align:left"><b style="font-size:15;font-family:Times New Roman;color:Red">Calculate seniority until date</b> </td>
                         <td colspan=5 style="width:10%; border:0; text-align:left"><gw:datebox styles="width:100%" lang="<%=Session("Lang")%>"  id="dtTo_P" type="date" /></td>
                         <td>EX rate</td>
						 <td colspan=10 > <gw:textbox text="" id="textExchange" styles='width:100%'  /></td>
                         <td colspan=5 style="width:5%; border:0; text-align:right"><b style="font-size:large;"><gw:icon id="btProcess"   styles='width:80%' img="in"  text="Process"  onclick="OnProcess()"/></b> </td>
                         <td></td>
                         <td colspan=2 style="width:5%; border:0; text-align:right"><b style="font-size:large;"><gw:icon id="btDelete"   styles='width:80%' img="in"  text="Delete"  onclick="OnDelete(2)"/></b> </td>
                         
                         
                    </tr>
					<tr width="100%" height="2%"><td></td></tr>
					<tr>
						<td colspan="5" align="left"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
						<td colspan="15">
							<gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%' >
								<data>
									<%= ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
								</data>
							</gw:list>
						</td>
						<td colspan="10" align="right">Employee Type</td>
						<td colspan="19">
							<gw:list  id="lstEmp_Type" value='ALL' maxlen = "100" styles='width:100%' >
								<data><%=ESysLib.SetListDataSQL("select v.code,code_nm from vhr_hr_code v where v.id='HR0017' order by v.seq")%>|ALL|Select All</data>
							</gw:list
						</td>
						<td colspan="6" align="right" >Work Group</td>
                        <td colspan="19" align="left" >
                         <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>
									<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
							</data></gw:list>
                        </td>
						
						<td  colspan="12" align="right" >
                            Contract Type</td>
                        <td colspan="14"  align="left" >
                         <gw:list  id="lstContract_Type" value='ALL' maxlen = "100" styles='width:100%' >
                           	<data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm")%>|ALL|Select All</data></gw:list>
                        </td>
                        
											
					</tr>
					<tr style="border:0;width:100%" valign="center" >
                        <td colspan="5"  align="right" valign="middle">Search by</td>
					    <td colspan="7"  style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                         <td colspan="8"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
						
                        <td colspan="10" align="right"><strong><font color="#000000">Join Date</font></strong></td>
					    <td colspan="9" align="left" >
								    <gw:datebox styles="width:60%"  nullaccept lang="<%=Session("Lang")%>"  id="dtJoinFrom" type="date">
								    </gw:datebox>
					    </td>
					    <td colspan="1" align="center"><strong><font color="#000000"> ~ </font></strong></td>
					    <td colspan="9"><gw:datebox styles="width:60%" nullaccept lang="<%=Session("Lang")%>"  id="dtJoinTo" type="date">
								    </gw:datebox>
					    </td>
                        <td colspan="6" align="right"><strong><font color="#000000">Left Date</font></strong></td>
					    <td colspan="9" align="left" >
								    <gw:datebox styles="width:100%" nullaccept lang="<%=Session("Lang")%>"  id="dtLeftFrom" type="date">
								    </gw:datebox>
					    </td>
					    <td colspan="1" align="center"><strong><font color="#000000"> ~ </font></strong></td>
					    <td colspan="9"><gw:datebox styles="width:100%"  nullaccept lang="<%=Session("Lang")%>"  id="dtLeftTo" type="date">
								    </gw:datebox>
					    </td>
                        <td colspan="12"  align="right" >Nation</td>
						<td colspan="14" align="left" ><gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
				
                        
                    </tr>
                    <tr style="border:0;width:100%" valign="middle" >
                        <td  colspan="5" align="right" >Amount</td>
                        <td  colspan="15"  align="left" >
							 <gw:list  id="lstType" value='>0' maxlen = "100" styles='width:100%' >
								<data>LIST|>0|>0|=0|=0|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan="10"  align="right" >Seniority</td>
                        <td colspan="9"  align="left" >
                         <gw:textbox id="txtSenForm"     styles='width:100%'/>
                        </td>
                        <td align=center>~</td>
                        <td colspan="9"  align="left" >
                         <gw:textbox id="txtSenTo"   styles='width:100%'/>
                        </td>
                         <td  colspan="6" align="right" >Set Amount</td>
                        <td  colspan="9"  align="left" >
							  <gw:textbox id="txtAmount"     styles='width:100%'/>
                        </td>
                        <td colspan="2"><gw:imgBtn img="set" id="ibtSet"   alt="Set Amount into Bonus Amt col"  onclick="OnSetGrid()"/></td>
                        <td  align="right"  colspan="14"><gw:label id="idInterval" text="" styles="width:100%;color:red" ></gw:label></td>
                        <td  align="right"  colspan="11"><gw:label id="idRecord" text="0 (rec)" styles="width:100%;color:red" ></gw:label></td>
                        
                        
                        <td  align="right"  colspan="2">
                         <gw:imgBtn img="search" id="ibtnSearch_B"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td   align="right"  colspan="2">
                         <gw:imgBtn img="save" id="ibtnSave_B"    alt="Save"  onclick="OnSave(3)"/>
                        </td>
                        <td  align="right"  colspan="2">
                         <gw:imgBtn img="excel" id="ibtnPrinter_B"    alt="Report"  onclick="OnReport(3)"/>
                        </td>

                        <td  align="right"  colspan="2">
                         <gw:imgBtn img="delete" id="ibtnDelete"   alt="Delete"  onclick="OnDeleteDetail()"/>
                        </td>
						                      
                    </tr>
					<tr style="width:100%;height:100%" valign="top">
                        <td colspan="100" style="width:100%;height:100%"> 
                           <gw:grid id="grdBonusAMT" 
					        header="_bn_pk|_emp_pk|_year|_Times|Organization|Emp ID|Full Name|Join Date|Left Date|Seniority |Ratio|Salary|Bonus Amount|By Hand" 
					        format="0|0|0|0|0|0|0|4|4|1|1|1|1|0" 
					        aligns="0|0|0|0|0|0|0|0|1|1|1|1|1|1" 
					        defaults="|||||||||||||" 
					        editcol="0|0|0|0|0|0|0|0|0|0|0|1|1|1" 
					        widths="0|0|0|0|1500|2000|1500|1500|2000|1500|1500|1500|1500|1500" 
					        styles="width:100%; height:100%" 
					        sorting="T" acceptNullDate 
					        oncelldblclick="" />				                         
                        </td>
                    </tr>
					
                </table>
            </td>
        </tr>
    </table>
</gw:tab>
</body>
<gw:textbox id="txtClose" styles="display:none"/>
<gw:textbox id="txtDateFrom" styles="display:none"/>
<gw:textbox id="txtDateTo" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtDept_PK" styles="display:none"/>
<gw:textbox id="txtOption" text="1" styles="display:none"/> 
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtTemp1" styles="display:none"/>
<gw:textbox id="txtTemp2" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none" text="0"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtOptionJ" styles="display:none"/>
<gw:textbox id="txtFromJ" styles="display:none"/>
<gw:textbox id="txtToJ" styles="display:none"/>
<gw:textbox id="txtOptionL" styles="display:none"/>
<gw:textbox id="txtFromL" styles="display:none"/>
<gw:textbox id="txtToL" styles="display:none"/>
<gw:textbox id="txtOptionC" styles="display:none"/>
<gw:textbox id="txtContractType" styles="display:none"/>
<gw:textbox id="txtBonusMasterPK" styles="display:none"/>
<gw:textbox id="txt_temp" styles="display:none"/>	
</html>
