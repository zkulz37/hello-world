<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Starter</title>
</head>

<script>
function BodyInit()
{
	var data = '';
    var ctrl = grdStartTime.GetGridControl();
     ctrl.ColEditMask(12) = "##:##";  

	dsoStartTime.Call("SELECT");
}

function Update()
{
    if(CheckDataIsValid())
    {
        dsoStartTime.Call(); 
    }   
}

function OnSearch()
{
     dsoStartTime.Call("SELECT");
}

function SetTime()
{
    var StartTime="";
		StartTime = txtStartTime.GetData();	
		for (i = 1; i < grdStartTime.rows; i++)	
		{
			    if (grdStartTime.GetGridData(i, 12)  == "")
			    {
				    grdStartTime.SetGridText( i , 12, StartTime);	

			    }
		}
}
function HourMin()
{
    var HHMM;
    var currentTime = new Date();
    var hours = currentTime.getHours();
    var minutes = currentTime.getMinutes();
    hours = ( hours < 10 ? "0" : "" ) + hours;
    minutes = ( minutes < 10 ? "0" : "" ) + minutes

    HHMM = hours + ":" + minutes;
    txtStartTime.SetDataText(HHMM); 
    
}
function Settime()
{
  setInterval('HourMin()', 1000 );  
}
function OnDataReceive(obj)
{
    if(obj.id=='dsoStartTime')
    {
        Settime();
    }
}
function CheckDataIsValid()
{
    for(var i=1;i<grdStartTime.rows;i++)
          {
            if(grdStartTime.GetGridData(i,12) == "")
             {
                alert("Please input start time row "+ i);
                return false;
             }
          }
          return true;
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dsoStartTime" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,12" function="crm.sp_sel_jast0020" procedure="crm.sp_upd_jast0020">  
                <input bind="grdStartTime">  
                <input bind="txtCardNo"/> 
                </input>
                <output bind="grdStartTime" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td>
                            <fieldset>
                                <table>
                                    <tr>
                                        <td width="15%">
                                            Bagtag No
                                        </td>
                                        <td width="35%" align="left">
                                            <gw:textbox id="txtCardNo" onenterkey="OnSearch()" />
                                        </td>
                                        <td width="5%">
                                        </td>
                                        <td style="width: 5%">
                                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                                            </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td>
                            <fieldset>
                                <table>
                                    <tr>
                                        <td width="29%" align="right">
                                            Start Time
                                        </td>
                                        <td width="10%">
                                            <gw:textbox id="txtStartTime"  styles="text-align:center;width:100%;" />
                                        </td>
                                        <td width="3%" style="border: 0">
                                            <gw:icon id="ibtnSetTime" alt="SetTime" text="SetTime" img="in" styles="width:100%"
                                                onclick="SetTime()" />
                                        </td>
                                        <td width="3%" style="border: 0">
                                                <gw:icon id="ibtnUpdate" alt="Update" text="Update" img="in" styles="width:100%"
                                                    onclick="Update()" />
                                            </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="9">
                            <gw:grid id='grdStartTime' header='_PK|No|Group No|Player Name|Tee Time|Gender|_Company|Bagtag No|Locker No|_Group|Caddy No|Caddy Name|Start Time'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|1' autosize="T"
                                sorting='T' styles='width:100%; height:100%'
                                autosize='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
