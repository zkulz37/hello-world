<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Get Time To Play</title>
</head>
<%  ESysLib.SetUser("crm")
  
%>

<script>


//-----------------------------------------------------------
var today ;
var  golf_type   ;
var  date ;
var now= new Date();
var hour = now.getHours();
var min = now.getMinutes();
var time="";
function GetMin()
{
    if(min<10)
    {
        min='0'+''+min;
        
    }
    if(hour<10)
    {
        hour='0'+''+hour;
    }
}
function BodyInit()
{
    golf_type    = "<%=request.QueryString("golf_type")%>" ;
    date         = "<%=request.QueryString("day")%>" ; 
    dtDate.value=date;   
    txtGolfType.text = golf_type;
    txtDate.text=date;
    data_jabk0032_3.Call("SELECT");
    today=dtDate1.value;
    GetMin();
    time=hour+''+min;    
}
//-----------------------------------------------------------

function OnSearch()
{
    data_jabk0032_1.Call("SELECT");
}

//-----------------------------------------------------------
function OnCheckData()
{
    var col=event.col;
    var row=event.row;
    var h= idGrid.GetGridData(row,col);
    var time_2 = h.substring(0,2);
    var min_2 = h.substring(3,5);
    var c = time_2+''+min_2;
    /*
    for(var h=1;h<idGrid1.rows;h++)
    {
        if(idGrid1.GetGridData(h,0)==date||idGrid1.GetGridData(h,0)==dtDate.value)
        {
            if(idGrid.GetGridData(row,col)==idGrid1.GetGridData(h,1))
            {
                alert("This Time Booked!!!");
                return false;
            }
        }
        
    }*/
    if(date==today && dtDate.value==today)
    {
        if(time>c)
        {
            alert("This Time Closed!!!");
            return false;
        }
    }
    if(date<today && dtDate.value<today)
    {
        alert("This Time Closed!!!");
        return false;
    }
    if(date>=today && dtDate.value<today)
    {
        alert("This Time Closed!!!");
        return false;
    }
    if (date<today && dtDate.value >=today)
    {
        return true;
    }
    if(date>=today && dtDate.value>=today)
    {
        return true;
    }
    return true;
}
//---------------------------------------------------------
function OnSelect()
{

    if(OnCheckData())
    {
        var code_data=new Array() 
	    var row=event.row;
	    var col=event.col;
        code_data[0] = idGrid.GetGridData(row , col );
        code_data[1] = dtDate.value;
	    window.returnValue = code_data; 
	    this.close(); 	
	}
}

//-----------------------------------------------------------
function OnCancel()
{
    var code_data=new Array()
    
    for( j=0 ; j < idGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//-----------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case"data_jabk0032_3":
            data_jabk0032.Call("SELECT");
        break;
        
        case "data_jabk0032":
            if(date<today)
            {
                for(var i=1;i<idGrid.rows;i++)
                {
                    idGrid.SetCellBgColor(i,0,i,12,0xC7DFDE);
                }
                var a=idGrid.GetGridData(1,1);
            }
            if(date==today)
            {
                var a="";
                var time_1="";
                var min_1="";
                var b="";
                for(var i=1;i<idGrid.rows;i++)
                {
                    for(j=0;j<13;j++)
                    {
                         a=idGrid.GetGridData(i,j);
                         time_1 = a.substring(0,2);
                         min_1 = a.substring(3,5);
                         b=time_1+''+min_1;
                        if(Number(time)>Number(b))
                        { 
                            idGrid.SetCellBgColor(i,j,i,j,0xC7DFDE);
                        }
                    }
                }
            }
            for(var i=1;i<idGrid.rows;i++)
            {
                 for(j=0;j<13;j++)
                 {
                      for(k=1;k<idGrid1.rows;k++)
                      {
                         var thoigian =idGrid.GetGridData(i,j);
                         var dachon=idGrid1.GetGridData(k,1);
                         if(date==idGrid1.GetGridData(k,0))
                         {
                            if(thoigian==dachon)
                            {
                                idGrid.SetCellBgColor(i,j,i,j,0xC7DFDE);
                            }
                         }
                      }   
                 }
            }
            
        break;
        
        case 'data_jabk0032_1':
                  
             if(dtDate.value<today)
            {
                for(var i=1;i<idGrid.rows;i++)
                {
                    idGrid.SetCellBgColor(i,0,i,12,0xC7DFDE);
                }
            }
            if(dtDate.value==today)
            {
                var a="";
                var time_1="";
                var min_1="";
                var b="";
                for(var i=1;i<idGrid.rows;i++)
                {
                    for(j=0;j<13;j++)
                    {
                         a=idGrid.GetGridData(i,j);
                         time_1 = a.substring(0,2);
                         min_1 = a.substring(3,5);
                         b=time_1+''+min_1;
                        if(Number(time)>Number(b))
                        { 
                            idGrid.SetCellBgColor(i,j,i,j,0xC7DFDE);
                        }
                    }
                }
            }
            for(var i=1;i<idGrid.rows;i++)
            {
                 for(j=0;j<13;j++)
                 {
                      for(k=1;k<idGrid1.rows;k++)
                      {
                         var thoigian =idGrid.GetGridData(i,j);
                         var dachon=idGrid1.GetGridData(k,1);
                         if(dtDate.value==idGrid1.GetGridData(k,0))
                         {
                            if(thoigian==dachon)
                            {
                                idGrid.SetCellBgColor(i,j,i,j,0xC7DFDE);
                            }
                         }
                      }   
                 }
            }     
        break; 
          
    }
}
//-----------------------------------------------------------

</script>

<body>
    <!------------------------------------------------------------------------>
    <gw:data id="data_jabk0032" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="CRM.sp_sel_tcm_teetime_sheet" > 
                  <input bind="idGrid" > 
                    <input bind="txtGolfType" />
                    <input bind="txtDate" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <gw:data id="data_jabk0032_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="CRM.sp_sel_tcm_teetime_sheet" > 
                  <input bind="idGrid" > 
                    <input bind="txtGolfType" />
                    <input bind="dtDate" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <gw:data id="data_jabk0032_3" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="CRM.sp_sel_jabk0032_3" > 
                  <input bind="idGrid1" > 
                  <input bind="txtGolfType" />
                  </input>
                <output bind="idGrid1" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                <gw:datebox id="dtDate" lang="1" onchange="OnSearch()"/>
            </td>
            <td style="width: 60%" align="center">
                <b style="color: #1b2ff2">
                    <h2>
                        Teeup Time Booking</h2>
                </b>
            </td>
            <td style="width: 3%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="4">
                <gw:grid id='idGrid' header='06:00|07:00|08:00|09:00|10:00|11:00|12:00|13:00|14:00|15:00|16:00|17:00|18:00|_GOLF_TYPE'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0' defaults='|||||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='800|800|800|800|800|800|800|800|800|800|800|800|800|800'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
    <!------------------------------------------------------------------------>
    <gw:grid id='idGrid1' header='BOOK_DATE|BOOK_TIME' format='0|0' aligns='0|0' check='|'
        editcol='1|1' widths='1000|1000' sorting='T' autosize='T' styles='width:100%; height:460;display:none' />
    <gw:textbox id="txtGolfType" styles="width:100%; display:none" />
    <gw:textbox id="txtDate" styles="width:100%; display:none" />
    <gw:datebox id="dtDate1" lang="1" style="width: 100%; display: none" />
    <!------------------------------------------------------------------------>
</body>
</html>
