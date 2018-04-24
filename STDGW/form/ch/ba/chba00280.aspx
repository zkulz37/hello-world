<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var value_before=0;
var _days=0;
var tmp1,tmp2;
var flag_open=0;
var col_f=7;//col ngay dau tien
var col_e=37; //col ngay cuoi cung
var tab_no=0;
var check_init=0;
function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
	 idMon_fr2.SetEnable(false);
	 idMon_to2.SetEnable(false);
    SelectOption(1);    
         txt_WG_temp1.text="<%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0 order by nvl(seq,9999)")%>";
     txt_WS_temp.text="<%=ESysLib.SetListDataSQL("select pk, shift||'-'||remark from thr_work_shift a where a.del_if=0 and a.use_yn='Y'") %>";
    
    grdWork2.GetGridControl().FrozenCols =3;
    
    
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
          {
            datUser_info.Call(); 
          }
     else
     {      txtOrgPK.text=lstOrg2.value;
            datWorkGroup_info.Call();   
    }   
}
//-----------------------------------------------
function OnShowPopup(n)
{
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
         if (obj!=null)
        {      
             lstOrg2.value=obj;
             
             ChangeOrganization(n)
        }
}

//-----------------------------------------------
function OnDataReceive(obj)
{   
     if (obj.id=="datUser_info")
        {
            
            
            lstOrg2.SetDataText(txt_temp.text);
            txtOrgPK.text=lstOrg2.value;
            datWorkGroup_info.Call();
        }
       if (obj.id=="datWorkGroup_info")
        {
                lstWG2.SetDataText(txt_WG_temp.text+ "|ALL|Select All");
                lstWG2.value='ALL';
                datGet_period_kind.Call();
				
        }  
        if (obj.id=="datGet_period_kind")
         {
         idLst_period2.SetDataText(txt_Sal_kind.text+"|M|Month");
            datGet_Period.Call();
            //OnChangeMon2();
         }
        
   
    else if (obj.id=="datSunday")
     {
          fill_sunday();
          check_init=1;
     }
    if (obj.id=="datSch_mon_detail")
    {
        lblRecord2.text=grdWork2.rows-1 + " rec(s)";
        auto_resize_column(grdWork2,0,grdWork2.cols-1,0);
        fill_sunday();
		FillColor();
    }
    if(obj.id=="datGet_Period")
	{
	    
	    var n;
	    _days=daysInMonth(idMon_fr2.value.substring(4,6),idMon_fr2.value.substring(0,4));	
		tmp1=Number(idMon_fr2.value.substring(6,8));
		tmp2=Number(idMon_to2.value.substring(6,8));
		//alert(idMon_fr2.value);
        //alert(idMon_to2.value);
        //alert(_days);
		if(tmp2<_days)//chu ky giua thang
		{
		    for(var i=tmp1;i<=31+tmp2;i++)
		    {
		        if(i>31)
		            n=i-31
		         else
		            n=i   
		        grdWork2.SetGridText(0,i-tmp1+col_f,n);
		    }    
		    for(var i=1;i<=31-_days;i++)		     
             grdWork2.GetGridControl().ColHidden(col_f+_days-tmp1+i)=true;                          
		}
		else
		{
		    for(var i=1;i<=31;i++)
		        grdWork2.SetGridText(0,i+col_f-1,i);
		        
		    for(var i=1;i<=31-_days;i++)
		     grdWork2.GetGridControl().ColHidden(i+_days+col_f-1)=true;    
		} 
		
		if(idClose_flag2.text=="Y")
		{
		     idRecord.text="This month is close";
		     ibtnSave2.SetEnable(0);
		}     
		else
		{
		    idRecord.text="";     
		    ibtnSave2.SetEnable(1);
		   // inputfile..SetEnable(1);
		} 
		//FillColor();
		datSunday.Call("SELECT");   
	}   	   
   
}    
// -------------------------------------------
function FillColor()
{     _days=daysInMonth(idMon_fr2.value.substring(4,6),idMon_fr2.value.substring(0,4));	
		tmp1=Number(idMon_fr2.value.substring(6,8));
		tmp2=Number(idMon_to2.value.substring(6,8));
	if(_days==tmp2)
	 {for(var i=1;i<=grdWork2.rows-1;i++)
				{ for(var j=1;j<=31;j++)
		           {if(grdWork2.GetGridData(i,j+col_f-1)=="1")
						{
						grdWork2.SetCellBgColor(i, j+col_f-1,i, j+col_f-1, 0xFFFF00 ); 
						grdWork2.SetGridText(i,j+col_f-1,"");
						}
					if(grdWork2.GetGridData(i,j+col_f-1)=="2")
						{
						grdWork2.SetCellBgColor(i, j+col_f-1,i, j+col_f-1, 0x3366FF ); 
						grdWork2.SetGridText(i,j+col_f-1,"");
						}	
					if(grdWork2.GetGridData(i,5)>GetDate(j)|| (grdWork2.GetGridData(i,6)<=GetDate(j) && grdWork2.GetGridData(i,6)!=""))
						{
						grdWork2.SetCellBgColor(i, j+col_f-1,i, j+col_f-1, 0x666666 ); 
						grdWork2.SetGridText(i,j+col_f-1,"");
						}
					
					  
					}	//	alert(GetDate(j) + ""+grdWork2.GetGridData(i,5))
				   
		   
				}
	}
	else
			{ 
			var n;
			for(var i=1;i<=grdWork2.rows-1;i++)
			for(var j=tmp1;j<=31+tmp2;j++)
		           {if(grdWork2.GetGridData(i,j-tmp1+col_f)=="1")
						{
						grdWork2.SetCellBgColor(i, j-tmp1+col_f,i, j-tmp1+col_f, 0xFFFF00 ); 
						grdWork2.SetGridText(i,j-tmp1+col_f,"");
						}
					if(grdWork2.GetGridData(i,j-tmp1+col_f)=="2")
						{
						grdWork2.SetCellBgColor(i, j-tmp1+col_f,i, j-tmp1+col_f, 0x3366FF ); 
						grdWork2.SetGridText(i,j-tmp1+col_f,"");
						}	
				
						if(j>31)
						   { n=j-31				  
						   }
						 else
							n=j  
					//alert(grdWork2.GetGridData(i,6)+"<>"+GetDate(n));
					if(grdWork2.GetGridData(i,5)>GetDate(n)||  (grdWork2.GetGridData(i,6)<=GetDate(n)&& grdWork2.GetGridData(i,6)!=""))
						{
						grdWork2.SetCellBgColor(i, j-tmp1+col_f,i, j-tmp1+col_f, 0x666666 ); 
						grdWork2.SetGridText(i,j-tmp1+col_f,"");
						}	
				   }
		   
				}
				
            
}
//-----------------------------------------------
function SelectOption(obj)
{   
    switch (obj)
    {
        case 1:
            txtOption.text=1;
            break;
        case 2: 
            txtOption.text=2;
            break;
    }    
} 
function GetDate(dd)
{//alert(dd);

var n;
	    _days=daysInMonth(idMon_fr2.value.substring(4,6),idMon_fr2.value.substring(0,4));	
		tmp1=Number(idMon_fr2.value.substring(6,8));
		tmp2=Number(idMon_to2.value.substring(6,8));
		//alert(idMon_fr2.value);
        //alert(idMon_to2.value);
        //alert(_days);
		if(tmp2<_days)//chu ky giua thang
		{
		    for(var i=tmp1;i<=31+tmp2;i++)
		    {
		        if(i>31)
		           { n=i-31				  
				   }
		         else
		            n=i  
					 if(dd==n)
					 { if(i>31)
						yyyymmdd= idMon_to2.value.substring(0,6)+((dd<=9)?('0'+dd):(dd));
						else
						{yyyymmdd= idMon_fr2.value.substring(0,6)+((dd<=9)?('0'+dd):(dd));}
						
					//	alert( "aaaa " + " "+dd+"<>"+yyyymmdd)
						return  yyyymmdd;
					 }
				
		    }    
		    
		}
		else
		{
		   yyyymmdd= idMon_to2.value.substring(0,6)+((dd<=9)?('0'+dd):(dd));
		   //alert( "bbb "+dd+"<>"+yyyymmdd)
		   return  yyyymmdd;
		} 
		yyyymmdd="";
		return  yyyymmdd;
}
//---------------------------------
function OnSearch(n)
{
    if(check_init==1)
    {    datSch_mon_detail.Call("SELECT");    
    }            
        
}
//---------------------------------
function OnSetToGrid()
{
	
}
//--------------------------------------
function OnSave(n)
{
    if(check_init==1)
    {  
            if (confirm("Do you want to save?"))     
                datSch_mon_detail.Call();
    }            
}
//------------------------------------------
//----------------------------------------------

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tdDetail.style.display="none";
            tdDetail.style.width="0%";
            tdMaster.style.height="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show changed group";
			grdChangedGroup.ClearData();
        }
        else
        {
            imgMaster.status = "expand";
            tdDetail.style.display="";
            tdDetail.style.width="18%";
            tdMaster.style.height="82%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close changed group";
			
			
        }
  
}
//-----------------------
function show_detail()
{
   
}
function OnReport()
{
  
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function onPageActive()
{
    if(tabMain.GetCurrentPageNo()==1)
    {
        //onHide_column();
        if(flag_open==0)
        {
            flag_open=1;
            idMon_fr2.SetEnable(0);
            idMon_to2.SetEnable(0);
            OnChangeMon2();
         }   
        
    }
}
function onHide_column()
{
    //xac dinh thang co bao nhieu ngay 
     grdWork2.ClearData();   
        for(var i=7;i<=37;i++)
            grdWork2.GetGridControl().ColHidden(i)=0
            
        var n=getDaysInMonth(idWorkMon2.value);
        for(var i=n+7;i<=37;i++)
            grdWork2.GetGridControl().ColHidden(i)=1
     datSunday.Call("SELECT");       
}
function getDaysInMonth(yyyymm) //xac dinh thang do co bao nhieu ngay
{
   // returns the last day of a given month
    var m,y,tmpDate,checkMonth,lastDay
	
	m = Number(yyyymm.substr(4,2))-1;
		if(m==-1)
			m=Number(yyyymm.substr(5,1))-1;

	y = Number(yyyymm.substr(0,4));
	tmpDate = new Date(y, m, 28);
	checkMonth = tmpDate.getMonth();
	lastDay = 27;

    while(lastDay <= 31){
        temp = tmpDate.setDate(lastDay + 1);
        if(checkMonth != tmpDate.getMonth())
            break;
        lastDay++
    }
    return lastDay;
}
function fill_sunday()
{
    var tmp;
      
       grdWork2.SetCellBgColor(0, 0,0, grdWork2.cols-1, 0x000000);
      for(var i=1;i<grdWork3.rows;i++)
      {
        
        if(Number(grdWork3.GetGridData(i,0))<Number(idMon_fr2.value.substring(6,8)))
            tmp=31-Number(idMon_fr2.value.substring(6,8))+Number(grdWork3.GetGridData(i,0))+col_f;
        else
            tmp=Number(grdWork3.GetGridData(i,0))-Number(idMon_fr2.value.substring(6,8))+col_f;
            
        //alert(tmp);
		
        grdWork2.SetCellBgColor(0, tmp,0, tmp, 0x3366FF );  
      }  
} 
function on_check()
{
    var r=event.row;
    var c=event.col;
	str=grdWork2.GetGridData(event.row,event.col);
	str=str.replace(" ","");
	grdWork2.SetGridText(event.row,event.col,str)
	var arr=str.split("-"); 
    if( arr.length>1 && isNaN(arr[0]))
    {
        alert('Please input absence time and absence code on format ("Hours-absence_type" or "Absence type" ).\nNhập số giờ nghỉ theo đúng định dạng "Giờ-loại_nghỉ" hoặc "loại nghỉ"');
        //alert(value_before);
        grdWork2.SetGridText(r,c,value_before);
    }    
}
function on_save_before()
{
    value_before=grdWork2.GetGridData(event.row,event.col);
    //alert(value_before);
}
//-------------------tab 2---------------------------------------------------
function OnChangeMon2()
{
	for(var i=col_f;i<=col_e;i++)
		    grdWork2.GetGridControl().ColHidden(i)=false;
	datGet_Period.Call();
	
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}


function ChangeOrganization(n)
{   txtOrgPK.text=lstOrg2.value;
    datWorkGroup_info.Call();
}
function Popup()
{
    var col=event.col;
    var flag=0;
    if(col>=col_f)
    { var temp=grdWork2.GetGridData(event.row,col ).split("-")
	   var abs="";
	   if(temp.length>1)
	   abs=	temp[1];
        var fpath = System.RootURL + "/form/ch/ba/chba00280_1.aspx?abs_code=" + abs;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:25;dialogLeft:200;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
                grdWork2.SetGridText(event.row,col,obj[1]);
         
        }
           
    }
   
}

</script>

<body>
<!------------main control---------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
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
<!-------------------------------------------------------->
<gw:data id="datGet_period_kind" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_get_period_by_org"  > 
                <input>
                    <input bind="lstOrg2" />
                </input> 
                <output>
                    <output bind="txt_Sal_kind" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!---------------------tab 2 ----------------------------------->
<gw:data id="datSunday" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="HR_sp_sel_sunday2"> 
                <input bind="grdWork3" >
                    <input bind="idWorkMon2" />
                    <input bind="idMon_fr2" />
                    <input bind="idMon_to2" />
                </input>
                <output  bind="grdWork3" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datSch_mon_detail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40" function="HR_sel_chba10020280_abs_month" procedure="HR_upd_chba10020280_abs_month"> 
                <input bind="grdWork2" >
                    <input bind="lstOrg2" />
                    <input bind="lstWG2" />
                    <input bind="idWorkMon2" />
                    <input bind="idMon_fr2" />
                    <input bind="idMon_to2" />
                    <input bind="lstTemp2" />
                    <input bind="txtTemp2" />
                </input>
                <output  bind="grdWork2" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_Period" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_get_sal_period_by_org" > 
                <input >
                    <input bind="lstOrg2" />
                    <input bind="idWorkMon2" /> 
                    <input bind="idLst_period2" />
                </input>
                <output >
                    <output bind="idMon_fr2" /> 
                    <output bind="idMon_to2" /> 
                    <output bind="idnum_day2" />
                    <output bind="idClose_flag2" />  
                </output>
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table--------------------------------->

 <table name="Monthly Detail" id="Tab2" class="itable" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
        <tr>
            <td>
	            <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	                <tr style="height:6%;border:0">	
	                    <td align=right style="width:8%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		                <td align=right style="width:15%;border:0"><gw:list  id="lstOrg2" value='ALL'  maxlen = "100" styles='width:100%' onchange="ChangeOrganization(2)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select ALL 
                            </data>
                        </gw:list>
                    </td>
		                <td  align=right style="width:8%;border:0" >Work Group</td>
		                <td  align=right style="width:14%;border:0"><gw:list  id="lstWG2" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0")%>|ALL|Select All
                                </data>
                            </gw:list></td>
		                
                        <td align=right  style="width:2%;border:0"></td>
		                <td align=left  style="width:6%;border:0"><b>Search by</b></td>
		                <td align=right style="width:6%;border:0"><gw:list  id="lstTemp2" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list></td>
		                
		                <td align=right style="width:8%;border:1"><gw:textbox text="" id="txtTemp2" styles='width:100%' onenterkey="OnSearch(2)" /></td>
                        <td  align=center style="width:18%;border:0"></td>
                        <td align="center" style="width:7%;border:0" ><b style="color=#FF00CC; font-size:12"><gw:label id="lblRecord2" text="0 rec(s)" styles="width:100%" ></gw:label></b></td>
		                <td align=center style="width:4%;border:0"><gw:imgBtn id="ibtnSearch2" alt="Search" img="search" text="Search" onclick="OnSearch(2)" /></td>
		                <td align=right style="width:4%;border:0"><gw:imgBtn id="ibtnSave2" alt="Save" img="save" text="Save" onclick="OnSave(2)" /></td>
		                
                    </tr>	
                    <tr style="height:6%;border:0">	
                        <td align=right style="width:8%;border:0" ><b>Month Type</b></td>
	                    <td style="width:8%;border:0"><gw:list  id="idLst_period2" value='01' maxlen = "100" styles='width:100%' onchange="OnChangeMon2()">
                                <data> <%=ESysLib.SetListDataSQL("SELECT P.C1,P.C2     FROM(select S.ID C1,A.CODE_NM||' '|| A.CHAR_1||'->'||A.CHAR_2 C2      from thr_close s,VHR_HR_CODE A        where s.del_if=0 and a.ID='HR0030'   and s.id=a.code) P   GROUP BY P.C1,P.C2  ORDER BY P.C1")%>|M|By Month</data>
                            </gw:list>
                        </td>
					    <td align=right style="width:8%;border:0" ><b>Work Mon</b></td>
		                <td align=left style="width:8%;border:0" ><gw:datebox id="idWorkMon2"  type="month" lang="<%=Session("Lang")%>" onchange="OnChangeMon2()" /></td>					            	
					    <td align=right style="width:8%;border:0"  >From</td>
		                <td align=left style="width:8%;border:0"  >
						    <gw:datebox id="idMon_fr2"  lang="<%=Session("Lang")%>" onchange="" />
					    </td>		
					    <td align=center style="width:2%;border:0" ><b>~</b></td>	
					    <td align=left style="width:8%;border:0" >
						    <gw:datebox id="idMon_to2"  lang="<%=Session("Lang")%>" onchange="" />
					    </td>		
					    <td align="center" colspan=4 style="width:7%;border:0" ><b style="color=#FF00CC; font-size:12"><gw:label id="idRecord" text="" styles="width:100%" ></gw:label></b></td>
		                
                    </tr>	
                    
	             </table>
	             <table id="Table1" style="width:100%;height:88%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		            <tr style="height:100%">
			            <td id="Td1" width="100%">
				            <gw:grid   
				            id="grdWork2"  
				            header="_emp_pk|EMP ID|Full Name|Organization|WGroup|Join date|Left date|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_w_mon|_from|_to"   
				            format="0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				            defaults="|||||||||||||||||||||||||||||||||||||||"  
				            editcol="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
				            widths="0|1000|2500|2500|2500|1200|1200|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|0|0|0"  
				            styles="width:100%; height:100%"   
				            sorting="T"  
				            acceptNullDate
							oncelldblclick = "Popup()"
				            onafteredit     = "on_check()" 
				            onKeyPressEdit    = "on_save_before()" />
			            </td>
		            </tr>	
	            </table>
	          </td>
	     </tr> 
   </table>
 				            <gw:grid   
    id="grdWork3"  
    header="1"   
    format="0"  
    aligns="0"  
    defaults="|"  
    editcol="0"  
    widths="2500"  
    styles="width:100%; height:100%;display:none"   
    sorting="T"   
    />
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtOption" styles="display:none"/>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txt_temp" styles="display:none"/>	
    <gw:textbox id="txt_WS_temp" styles="display:none"/>	
    <gw:textbox id="txt_WG_temp1" styles="display:none"/>	
    <gw:textbox id="txt_WG_temp" styles="display:none"/>	
    <gw:textbox id="txt_Sal_kind" styles="display:none"/>	
    <gw:textbox id="txtOrgPK" styles="display:none"/>
    
    <gw:textbox id="idnum_day2" styles="display:none"/>
		<gw:textbox id="idClose_flag2" styles="display:none"/>
		<gw:textbox id="idResult2" styles="display:none"/>
    
</body>
</html>

