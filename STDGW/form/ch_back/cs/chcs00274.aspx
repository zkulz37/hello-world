<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var ajax_test;
var v_fac=0;
var process_flag=1;
var root_temp="";
var flag_daily=1;
var check_init=0;
var c_close_yn=8;


var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    

    if (v_language!="ENG")
        System.Translate(document);

    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
	txtCompany_pk.text="<%=Session("COMPANY_PK")%>";
    

    menu_id.text=System.Menu.GetMenuID();
    
    if(txtHr_level.text=="")
    {
        alert("Your session is time out, login again please!\nPhiên làm việc đã bị ngắt, vui lòng đăng nhập lại!")
    }    
    
   datCheck_View.Call();
    
}


//-----------------------------------------------
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

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}


function OnSearch()
{
    if(check_init==1)
        datCHCS00274_01.Call("SELECT");
}



function OnDataReceive(obj)
{
    
    if(obj.id == "datCheck_View")
    {
        if(txtFlag_View.text == 'Y')
        {
            ibUpdate.style.display = "none";
            
        }
        
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
        }
        else
            check_init =1;
    }
    if(obj.id=="datUser_info")
    {
        check_init =1;
    } 
    
    if(obj.id=="datCHCS00274_01")
    {
        idRecord.text=idGrid.rows-1 + " Rec(s)."
    }    
    
   
    
}



function OnUpdate()
{
    if(check_init==1)
    {
        if(confirm("Do you want to update?"))
                datCHCS00274_01.Call();
    }        
    
}          

function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
       
    }
    
}

</script>
<style>
.top { border-top:2px solid #034D72; }
.topright { border-top :2px solid #034D72;
			border-right: 2px solid #034D72;;padding-right:10px
			}
.topleft {border-left:2px solid #034D72; 
			border-top :2px solid #034D72;
			}
.left { border-left:2px solid #034D72; }
.right { border-right:2px solid #034D72;padding-right:10px }
.bottomright { border-bottom:2px solid #034D72; 
				border-right:2px solid #034D72; padding-right:10px
				}
.bottomleft { border-bottom:2px solid #034D72; 
				border-left:2px solid #034D72;;
			}
.bottomleftright { border-bottom:2px solid #034D72; 
				border-left:2px solid #034D72;;
				border-right:2px solid #034D72;;
			}			
.bottom { border-bottom:2px solid #034D72; }

#up { background-color:#DFF2FF; }
#down { background-color:#EAEAEA; }



</style>
<body>

<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_SP_PRO_CHECK_VIEW"  > 
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
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datCHCS00274_01" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7" function="HR_SEL_CHCS00274_01" procedure="HR_UPD_CHCS00274_01"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="idWork_mon" />
                    <input bind="lstHaveHoliday" />
                    <input bind="lstSearch" />
                    <input bind="txtSearchTmp" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>


<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="center" border="0" >
    <tr style="width:100%;height:1%">
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>	
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	    <td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td><td style="width:1%">&nbsp;</td>
	</tr>
	<tr style="width:100%;height:5%">
        <td colspan=6 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=14 align=right style="width:18%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="" >
                <data>
                    <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
	    <td colspan="10" align="right">Work Mon</td>
	    <td colspan="10"><gw:datebox id="idWork_mon"  maxlen = "10" onchange="" styles='width:100%' lang="<%=Session("Lang")%>" type=month /></td>
	    <td colspan="10" align="right">Have Holiday</td>
	    <td colspan="10"><gw:list  id="lstHaveHoliday"  maxlen = "100" value='0.1' styles='width:100%' onchange="" >
                <data>
                    |0.1|Y|0|N|-1|ALL
                </data>
            </gw:list>
        </td>
        <td colspan="10" align="right">Search by</td>
        <td colspan="10"><gw:list  id="lstSearch"  maxlen = "100" value='1' styles='width:100%' onchange="" >
                <data>|1|Emp ID</data>
            </gw:list>
        </td>
        <td colspan="10"><gw:textbox id="txtSearchTmp" styles="width:100%"/></td>
        <td colspan="5" align="center"><gw:icon img="in" id="ibSearch" text="Search" onclick="OnSearch()" /></td>
	    <td colspan="5" align="center"><gw:icon img="in" id="ibUpdate" text="Update" onclick="OnUpdate()" /></td>
	    
	</tr>
    <tr style="width:100%;height:5%">
	    <td colspan="90" align="center" style="color:Red"><b><i>(Tip):If you update holiday, you must process salary again.</i></b></td>
        <td colspan="10"><gw:label id="idRecord" text="" styles="width:100%" ></gw:label></td>
	    
	</tr>
	
	<tr style="width:100%;height:89%">
	    <td colspan="100">
	        <gw:grid
					id="idGrid"
					header="_PK|ORGANIZATION|EMP ID|FULL NAME|HOLIDAY(L1)|HOLIDAY(L2)|NOTE|FIX BYHAND|CLOSE Y/N"
					format="0|0|0|0|0|0|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0"
					defaults="||||||||"
					editcol="0|0|0|0|1|1|1|1|0"
					widths="0|3000|1500|3000|1500|1500|2000|2000|2000"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick = ""
			/>
	    </td>
	</tr>
</table>

</body>


<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtAction_Flag" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtBank_pk" styles="display:none"/>
<gw:textbox id="txtCompany_pk" styles="display:none"/>
<gw:textbox id="txtRef_pk" styles="display:none"/>
<gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />



</html>