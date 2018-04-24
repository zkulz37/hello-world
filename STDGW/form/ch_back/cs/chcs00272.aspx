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


var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    

    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtcompany_pk.text= "<%=session("COMPANY_PK")%>";
    
    if(txtHr_level.text=="")
    {
        alert("Your session is time out, login again please!\nPhiên làm việc đã bị ngắt, vui lòng đăng nhập lại!")
    }    
    
    datchcs00272_00.Call();
    
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
        datchcs00272_02.Call("SELECT");
}

function onCheck_Data()
{
    idGrid.ClearData();
    datchcs00272_01.Call();
}

function OnDataReceive(obj)
{
    if(obj.id=="datchcs00272_00")
    {
        datchcs00272_01.Call();
    }
    
    if(obj.id=="datchcs00272_01")
    {
        check_init=1;
    }
    
    if(obj.id=="datchcs00272_02")
    {
        idRecord.text=idGrid.rows-1 + " Rec(s)."
    }    
    
    if(obj.id=="datchcs00272_03")
    {
        if(txtResult.text=="0")
        {
            alert("Interface successfull");
            datchcs00272_00.Call();
        } 
        else
        {
            alert("Interface Error");
        }  
    }
    
}


function OnShowPopup()
{

   /* if(txtcompany_pk.text=="")
    {
        alert("There is no company assign for login account");
        return;
    }*/
    
        var fpath = System.RootURL + "/form/ch/cs/chcs00272_01.aspx?p_company_pk="+txtcompany_pk.text+"&p_ref_pk="+txtRef_pk.text;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:150;dialogHeight:60;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
           datchcs00272_00.Call();
}  

function OnInterface()
{
    if(check_init==1)
    {
        if(txtAction_Flag.text=="Y")
        {
            if(confirm("Do you want to make interface?"))
                datchcs00272_03.Call();
        }
        else
            alert("There is no data to interface");
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


<gw:data id="datchcs00272_00" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_sp_pro_CHCS00272_00"  > 
                <input>
                    <input bind="lstCurrency" />
                </input> 
                <output>
                    <output bind="lblBankInfor" />
                    <output bind="txtBank_pk" />
                    <output bind="txtRef_pk" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datchcs00272_01" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_sp_pro_CHCS00272_01"  > 
                <input>
                    <input bind="idWork_mon" />
                    <input bind="lstCurrency" />
                    <input bind="lstType" />
                </input> 
                <output>
                    <output bind="lblStatus" />
                    <output bind="txtAction_Flag" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchcs00272_03" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_sp_pro_CHCS00272_03"  > 
                <input>
                    <input bind="idWork_mon" />
                    <input bind="lstCurrency" />
                    <input bind="lstType" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchcs00272_02" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0" function="HR_SEL_CHCS00272_02" procedure=""> 
                <input bind="idGrid" >
                    <input bind="idWork_mon" />
                    <input bind="lstCurrency" />
                    <input bind="lstType" />
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
	    <td colspan="10" align="right">Work Mon</td>
	    <td colspan="10"><gw:datebox id="idWork_mon"  maxlen = "10" onchange="onCheck_Data()" styles='width:100%' lang="<%=Session("Lang")%>" type=month /></td>
	    <td colspan="10" align="right">Currency</td>
	    <td colspan="10"><gw:list  id="lstCurrency"  maxlen = "100" value='01' styles='width:100%' onchange="onCheck_Data()" >
                <data>
                    <%= ESysLib.SetListDataSQL("select V.CODE,V.CODE_NM from vhr_hr_code v where v.id='HR0040' ")%>
                </data>
            </gw:list>
        </td>
        <td colspan="15" align="right">Search by</td>
        <td colspan="10"><gw:list  id="lstSearch"  maxlen = "100" value='01' styles='width:100%' onchange="" >
                <data>|01|Emp ID|02|Bank Account</data>
            </gw:list>
        </td>
        <td colspan="10"><gw:textbox id="txtSearchTmp" styles="width:100%"/></td>
        <td colspan="10" align="center"><gw:icon img="in" id="ibSearch" text="Search" onclick="OnSearch()" /></td>
	    <td colspan="10" align="center"><gw:icon img="in" id="ibInterface" text="Interface" onclick="OnInterface()" /></td>
	    <td colspan="5"><gw:label id="idRecord" text="" styles="width:100%" ></gw:label></td>
	</tr>
	<tr style="width:100%;height:5%">
	    <td colspan="15" align="right"><a title="Click here to select bank account" onclick="OnShowPopup()" href="#tips" >
                            Company Bank Account</a></td>
	    <td colspan="30" align=center><gw:label id="lblBankInfor" text="" styles="width:100%;color:red" ></gw:label></td>
	    <td colspan="10" align="right">Type</td>
	    <td colspan="10"><gw:list  id="lstType"  maxlen = "100" value='01' styles='width:100%' onchange="onCheck_Data()" >
                <data>
                    |01|Local Banking|02|Other Banking|03|Oversea Banking
                </data>
            </gw:list>
        </td>
        <td colspan="25" align=center><gw:label id="lblStatus" text="" styles="width:100%" ></gw:label></td>
	    <td colspan="10" align=center ><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
	    
	</tr>
	<tr style="width:100%;height:89%">
	    <td colspan="100">
	        <gw:grid
					id="idGrid"
					header="_EMP_PK|ORGANIZATION|EMP ID|FULL NAME|AMOUNT|BANK ACCOUNT|BANK NAME|BANK CODE|BANK ADDR"
					format="0|0|0|0|-2|0|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0"
					defaults="||||||||"
					editcol="0|0|0|0|0|0|0|0|0"
					widths="0|3000|1500|3000|2000|3000|3000|2000|3000"
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
<gw:textbox id="txtcompany_pk" styles="display:none"/>
<gw:textbox id="txtRef_pk" styles="display:none"/>




</html>