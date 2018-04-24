<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var col_f = 1; //col ngay dau tien
var col_e = 31; //col ngay cuoi cung
var check_init = 0;
var value_before=0;
var v_language = "<%=Session("SESSION_LANG")%>";

//header="Organization|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_org_pk|_from"   

var p_org=0;
var p_1=1;
var p_2=2;
var p_3=3;
var p_4=4;
var p_5=5;
var p_6=6;
var p_7=7;
var p_8=8;
var p_9=9;
var p_10=10;
var p_11=11;
var p_12=12;
var p_13=13;
var p_14=14;
var p_15=15;
var p_16=16;
var p_17=17;
var p_18=18;
var p_19=19;
var p_20=20;
var p_21=21;
var p_22=22;
var p_23=23;
var p_24=24;
var p_25=25;
var p_26=26;
var p_27=27;
var p_28=28;
var p_29=29;
var p_30=30;
var p_31=31;
var p_org_pk=32;
var p_from=33;

function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);	
         
	iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    idMon_fr.SetEnable(false);
    idMon_to.SetEnable(false);
    			
    ChangeColorItem(lstOrg.GetControl());        

	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call(); 
    else
    {            	    
        onHide_column();
    }      
}

function ChangeColorItem(lstctl) 
{
    var slevel1, slevel2, slevel3, slevel4;
    for (var i = 0; i < lstctl.options.length; i++) {
        slevel1 = lstctl.options.item(i).text.substr(0, 1);
        slevel2 = lstctl.options.item(i).text.substr(0, 3);
        slevel3 = lstctl.options.item(i).text.substr(0, 5);
        slevel4 = lstctl.options.item(i).text.substr(0, 7);
        if (slevel4 != ".......") {
            if (slevel3 == ".....") {
                lstctl.options.item(i).style.color = "0066CC";
            }
            else {
                if (slevel2 == "...") {
                    lstctl.options.item(i).style.color = "FF4500";
                }
                else {
                    if (slevel1 == ".")
                        lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                }
            }
        }
    }
}

function OnDataReceive(obj)
{    
    if (obj.id=="datUser_info")
        {     
            if(txtHr_level.text=="6")
            {
                txt_temp.text=txt_temp.text+"|ALL|Select All"; 
            }      
            lstOrg.SetDataText(txt_temp.text); 
            ChangeColorItem(lstOrg.GetControl()); 
            onHide_column();                                               
        }   
    else if(obj.id=="datGet_Period")
	{	  
		//alert(idClose_flag.text);
		if(idClose_flag.text=="Y")
		{
		        lblRecord.text="This month is close.";
				//ibtnSave.SetEnable(0);
		        ibtnSave.SetEnable(1);
		}     
		else
		{
		    lblRecord.text="0 Record(s)";     
		    ibtnSave.SetEnable(1);
		} 
		datSunday.Call("SELECT");
    }
    else if (obj.id == "datSunday") 
    {
        fill_sunday();
        GetListMon.Call();        
    }
    else if (obj.id == "GetListMon") 
    {
        lstMon_fr.SetDataText(txt_mon_temp.text); 
        lstMon_to.SetDataText(txt_mon_temp.text); 
        check_init = 1;
    }    
    else if (obj.id == "datMaxOT_Info") 
    {
        lblRecord.text=grdWork.rows-1 + " Record(s)";
    }    
}
function fill_sunday() 
{
    var tmp;

    grdWork.SetCellBgColor(0, 0, 0, grdWork.cols - 1, 0x000000);
    
    for (var i = 1; i < grdWork2.rows; i++) 
    {

        if (Number(grdWork2.GetGridData(i, 0)) < Number(idMon_fr.value.substring(6, 8)))
            tmp = 31 - Number(idMon_fr.value.substring(6, 8)) + Number(grdWork2.GetGridData(i, 0)) + col_f;
        else
            tmp = Number(grdWork2.GetGridData(i, 0)) - Number(idMon_fr.value.substring(6, 8)) + col_f;
                    
        grdWork.SetCellBgColor(0, tmp, grdWork.rows - 1, tmp, 0x3366FF);
    }
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

function onHide_column()
{
    //xac dinh thang co bao nhieu ngay    
    grdWork.ClearData();   
    for(var i=1;i<=31;i++)
        grdWork.GetGridControl().ColHidden(i)=0   //hien

    var n = getDaysInMonth(idWorkMon.value);   
    for(var i=n+1;i<=31;i++)
        grdWork.GetGridControl().ColHidden(i)=1   //an
    OnChangeMon();		 
}
function OnChangeMon()
{
	datGet_Period.Call();	
}


//----------------------
function OnSearch()
{
    datMaxOT_Info.Call("SELECT");
}
function OnUpdate()
{
    datMaxOT_Info.Call();
}
//function on_save_before()
//{
//    value_before=grdWork2.GetGridData(event.row,event.col);
//    //alert(value_before);
//}
function on_check()
{
    var r=event.row;
    var c=event.col;
    if(c>0 && isNaN(grdWork.GetGridData(event.row,event.col)))
    {
        alert("Incorrect number of max ot.\nNhập giá trị số cho max ot");
        //alert(value_before);
        grdWork.SetGridText(r,c,value_before);
    }    
}

function on_click()
{
//    col=event.col;
//    row=event.row;
//    alert(event.row);
//    alert(event.col);
    value_before=grdWork.GetGridData(event.row,event.col);
//    alert(value_before);
}

function OnSetToGrid()
{  
    if(Number(idtxtValue.text)>=0)
    {
            if(Number(lstMon_fr.value) >Number(lstMon_to.value))
            {  
                alert("From day <= To day.");
                return;
            }
            else
            {
                if(Number(idtxtValue.text)>=0)
                {
                    if(grdWork.rows>1)
                    {
                        var ctrl=grdWork.GetGridControl();                    
                        if(ctrl.SelectedRows>0)
                        {
                            for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
                            {
                                for(var k=Number(lstMon_fr.value);k<=Number(lstMon_to.value);k++)
                                {
            	                    grdWork.SetGridText(ctrl.SelectedRow(i),k,idtxtValue.text);
                                    //alert(k); 
                                }
                            }
                             
        			    }
                    }
                    else
                    {
                        if(confirm("Do you want to set all rows?\nBạn có muốn set hết tất cả các dòng ở dưới lưới"))
                        {
                            for ( var i =  1 ; i < ctrl.Rows ; i++ )
                            {
                                for(var k=Number(lstMon_fr.value);k<=Number(lstMon_to.value);k++)
                                {
            	                    grdWork.SetGridText(i,k,idtxtValue.text);
                                }
                            }
                        }
                    }
                } //if(Number(idtxtValue.text)>0)
                     
            }  //if(lstMon_fr.value >lstMon_to.value)
    }  //if(Number(idtxtValue.text)>=0)
    else
    {
        alert("You input number value.");
        return;
    }         
}
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
function OnReport(n)
{    
    var url=System.RootURL+'/reports/ch/om/rpt_monthly_max_ot.aspx?p_org_pk='+lstOrg.value+'&p_month='+idWorkMon.value+'&p_from='+idMon_fr.value+'&p_to='+idMon_to.value;    
    window.open(url);
}
</script>

<body>  
<!--------Control-------------->

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
<gw:data id="GetListMon" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_get_mon"  > 
                <input>
                    <input bind="lstOrg" />
                    <input bind="idWorkMon" />
                </input> 
                <output>
                    <output bind="txt_mon_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datGet_Period" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_get_fromto_by_org" > 
                <input >
                    <input bind="lstOrg" />
                    <input bind="idWorkMon" /> 
                    <input bind="idLst_period" />                    
                </input>
                <output >
                    <output bind="idMon_fr" /> 
                    <output bind="idMon_to" /> 
                    <output bind="idnum_day" />
                    <output bind="idClose_flag" />  
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datSunday" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="HR_sel_sunday2_byorg"> 
                <input bind="grdWork2" >
                    <input bind="lstOrg" />
                    <input bind="idWorkMon" />
                     <input bind="idMon_fr" />
                    <input bind="idMon_to" />
                </input>
                <output  bind="grdWork2" />
            </dso> 
        </xml> 
</gw:data>

<%--header="Organization|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_org_pk|_from" --%>
<gw:data id="datMaxOT_Info" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34" function="hr_sel_1015005_max_OT" procedure="hr_upd_1015005_max_OT"> 
                <input bind="grdWork" >
                    <input bind="lstOrg" />
                    <input bind="idMon_fr" />
                    <input bind="idMon_to" />                                        
                </input>
                <output  bind="grdWork" />
                
            </dso> 
        </xml> 
</gw:data>


<!--------Giao dien-------------->  
   <table name="Max OT" id="Tab2" class="itable" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
        <tr>
            <td>
	            <table style="width:100%;height:8%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	                <tr style="height:4%;border:1">			                
		                <td align=right style="width:6%;border:0" >Organization</td>
		                <td colspan=3 align=right style="width:15%;border:0">
		                    <gw:list  id="lstOrg" value="" maxlen = "100" styles='width:100%' onchange="" >
		                        <data>
			                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
		                        </data>
	                        </gw:list>
                        </td>		                		                
                        <td align=right colspan=1 style="width:8%;border:0"><b>Work Mon</b></td>
		                <td align=left colspan=2 style="width:8%;border:0"><gw:datebox id="idWorkMon"  maxlen = "10" type="month" styles='width:60%'lang="<%=Session("Lang")%>" onchange="onHide_column()" /></td>
		                 <td align=right style="width:8%;border:0"  >From</td>
		                <td align=left colspan=4  style="width:8%;border:0"  >
						    <gw:datebox id="idMon_fr"  lang="<%=Session("Lang")%>" onchange="" />
					    </td>		
					    <td align=center style="width:2%;border:0" ><b>~</b></td>	
					    <td align=left style="width:8%;border:0" >
						    <gw:datebox id="idMon_to"  lang="<%=Session("Lang")%>" onchange="" />
					    </td>		
		                
                        <td align=left style="width:2%;border:1"></td>               
		                <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		                <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		                <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
		                
                    </tr>	
                    <tr style="height:4%;border:0">	
		                <td align=right>From Day</td>
                        <td style="width:5%">
                            <gw:list  id="lstMon_fr" value='' maxlen = "100" styles='width:100%' >
                            <data></data>
                            </gw:list>
                        </td>  
                        <td align=center style="width:4%">To Day</td> 
                        <td align=left style="width:5%">
                            <gw:list  id="lstMon_to" value='' maxlen = "100" styles='width:100%' >
                            <data></data>
                            </gw:list>
                        </td>                         
                        <td colspan=1 align=right><gw:textbox id="idtxtValue" maxlen = "50" styles="width:100%" onkeypress="" /></td>       
                        <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSet" alt="Set to Grid" img="set" text="" onclick="OnSetToGrid()" /></td>                     
                        <td colspan=11 align=right <b style="border:0"><gw:label id="lblRecord" text="0 record(s)" styles="color:red;width:100%;font-weight: bold;font-size:12" ></gw:label></b></td>		                
                    </tr>	
	             </table>
	             <table id="Table1" style="width:100%;height:88%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		            <tr style="height:100%">
			            <td id="Td1" width="100%">
				            <gw:grid   
				            id="grdWork"  
				            header="Organization|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_org_pk|_from|_to"   
				            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				            aligns="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
				            defaults="||||||||||||||||||||||||||||||||||"  
				            editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
				            widths="2500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|0|0|0"  
				            styles="width:100%; height:100%"   
				            sorting="T"   
                            onafteredit     = "on_check()"                                                     
                            oncellclick       ="on_click()"
                            /> 				            
			            </td>
		            </tr>	
	            </table>
	          </td>
	     </tr> 
  </table>     
</body>
      <gw:textbox id="iduser_pk" styles="display:none"/>
      <gw:textbox id="txtHr_level" styles="display:none"/>
      <gw:textbox id="txt_temp" styles="display:none"/>	
      <gw:textbox id="txt_mon_temp" styles="display:none"/>	

      <gw:textbox id="idnum_day" styles="display:none"/>
      <gw:textbox id="idClose_flag" styles="display:none"/>
      <gw:textbox id="idLst_period" text='01' styles="display:none"/>

      <gw:grid   
        id="grdWork2"  
        header="1"   
        format="0"  
        aligns="0"  
        defaults="|"  
        editcol="0"  
        widths="2500"  
        styles="width:100%; height:100%;display:none"   
        sorting="T"   
        />  		
</html>

