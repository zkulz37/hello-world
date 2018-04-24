<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
    <style type="text/css">
        a:link {color:#3333ff;text-decoration:none;font-weight:normal;}
	    a:visited {color:#3333ff;text-decoration:none;font-weight:normal;}
	    a:active {color:#3333ff;text-decoration:none;font-weight:normal;}
	    a:hover {color:#326da7;text-decoration:none;font-weight:bold}
	    .normals{font-family:Tahoma;font-size:11px;color:#3333ff;font-weight:normal;}
    </style>
  </head>
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <script>
 var grid_col=0;
 var ttRecord=0;
 var pgSize = 13;
 var pgCurr = 1;
 var iPage_Section_Cur=0;
 var iNum_Page=10;
    function BodyInit()
    {      
        datNews.StatusUpdate();
        OnInit();
    }
    function OnInit()
    {
        var pk = '<%=request.QueryString("pk")%>';
        txtNewsPK.text = "0";
        lbCount.text = "1";
        if(pk.length != 0)
        {
            txtNewsPK.text = pk;
            datNews.Call();            
        }
    }
    function OnRedirect(page)
    {
        var lc = location.href;
        var arr = lc.split("/");
        lc = "";
        for(var x=0; x<arr.length-1; x++)
        {
            lc += arr[x] + "/";
        }
        location.href = lc + page;
    }
    function OnBindHeader()
    {
        var s_header;
        s_header= txtHeader.text
        var arr = s_header.split(",");
        var css_format;
        s_header='<table cellpadding="0" cellspacing="0" border="0" width="100%"> <tr>';
        grid_col=arr.length;
        for(var x=0; x<arr.length; x++)
        {
             if (x==0)
                css_format='border-left:1px solid black';    
             else if (x==grid_col-1)
                css_format='border-right:1px solid black';    
             else
                css_format="";
            s_header +='   <td style="bordercolor:#326da7;color:#326da7;background-color:#ffffff;width:' + grid_col/100 + '%;padding-top:2px;border-top:1px solid black;border-bottom:1px solid black;height:25px;' + css_format + '" align="center">' + arr[x] + '</td>';
        }
        s_header +='</tr></table>';
        var obj = document.getElementById("header");
         obj.innerHTML = s_header;
    }
    function OnBindGrid(flag)
    {
        var i=1;
        if(grdNews.rows > 0)
        ttRecord = grdNews.rows-1;
        if(pgSize*pgCurr < ttRecord) ttRecord = pgSize*pgCurr;
        //alert(ttRecord);
        var strHTML='<table border="0" cellpadding="0" cellspacing="0" width="100%">';
            for(i=pgSize*(pgCurr-1)+1;i<=ttRecord;i++)
            {
                
                if(i%2==0)
                    strHTML += "<tr style='height:23px' bgcolor='ffffff'>";
                else 
                    strHTML += "<tr style='height:23px'  bgcolor='f7f6f6'>";
                for(var x=0; x<grid_col; x++)
                {
                    var css_format;
                    if (x==0)
                        css_format='border-left:1px solid black';    
                    else if (x==grid_col-1)
                        css_format='border-right:1px solid black';    
                    else
                        css_format='';
                    if (i==ttRecord)
                        css_format +=';border-bottom:1px solid black';
                    strHTML +='   <td style="width:' + grid_col/100 + '%;height:25px;' + css_format + '" align="center" class="normals">' + grdNews.GetGridData(i,x) + '</td>';
                }
                 strHTML += "</tr>";
                 
            }
         strHTML += "</table>";
         var obj = document.getElementById("grid");
         obj.innerHTML = strHTML;
         
         //BindPaging();
         BindPaging(flag);
    }

    function BindPaging(flag)
    {
        var ttPage=1;
        var i=0;
        var ttrc = grdNews.rows-1;
        if(ttrc%pgSize==0)
            ttPage = ttrc/pgSize;
        else 
            ttPage = ttrc/pgSize + 1;
        if (flag==2) //next page section 
            iPage_Section_Cur=iPage_Section_Cur + iNum_Page ;
        else if (flag==1) //bank page section
            iPage_Section_Cur=iPage_Section_Cur - iNum_Page ;
        var strHTML='<table border="0" cellpadding="0" cellspacing="0"><tr>';
        strHTML += "<td style='width:40px' align='center' class='normals'>";
        
        if(iPage_Section_Cur == 0)
            strHTML += "<span style='font-weight:bold;color:#0363b2'>Back</span>";
        else
        {
            var iback_page=iPage_Section_Cur - iNum_Page + 1;
            strHTML += "<a href='#' onclick='OnPaging("+ iback_page +",1)'>Back</a>";
        }
        strHTML += "</td>";    
        for(i = iPage_Section_Cur+1; i <= ttPage && i<= iPage_Section_Cur +iNum_Page; i++)
        {
              strHTML += "<td style='width:20px' align='center' class='normals'>";
              if(pgCurr == i)
                    strHTML += "<span style='font-weight:bold;color:#0363b2'>[" + i + "]</span>";
              else strHTML += "<a href='#' onclick='OnPaging("+i+",0)'>"+i+"</a>";
              strHTML += "</td>";
        }
         strHTML += "<td style='width:40px' align='center' class='normals'>";
         if(i==ttPage+1 || i>ttPage)
            strHTML += "<span style='font-weight:bold;color:#0363b2'>Next</span>";
         else 
         {
            var inext=iPage_Section_Cur+iNum_Page+1;
            strHTML += "<a href='#' onclick='OnPaging("+inext +",2)'>Next</a>";
         }
        strHTML += "</td>";    
        strHTML += "</tr></table>";
        //alert(strHTML);
        var obj = document.getElementById("paging");
        obj.innerHTML = strHTML;
    }
    function OnPaging(pg,flag)
    {
        pgCurr = pg;
        OnBindGrid(flag);
    }
    function OnDataReceive(obj)
    {
        if (obj.id=="datNews")
        {
            if (txtURL.text=="")
            {
                var link= document.all("link");
                link.style.display="none"
            }
            if (txtHeader.text!="")
            {
                OnBindHeader();
                var s_sql;
                s_sql=txtSQL.text;
                txtSQL_Report.text=txtSQL.text;
                txtSQL.text=s_sql.replace(/\x27/g,"''");
                datAnnounce_Data.Call("SELECT");
            }
        }
        else if (obj.id=="datAnnounce_Data")
        {
            OnBindGrid(0);
            
        }
    }
    function OnDataError(oData)
    {
    }
    function OpenPopup(obj)
    {
        if (obj==1)
        {
            var temp=txtURL.text;
            var arr = temp.split("*");
            url= System.RootURL + '/'  + arr[0];
			alert(url);
            if (arr.length==4)
                System.Menu.NewWindow(url,arr[1],arr[2],arr[3]);
            else
                System.Menu.NewWindow(url,"new","new","new");
        }
        else
        {
            var strcom
            var fpath = System.RootURL + "/form/ch/ae/chae00230_popup_lb.aspx?p_header=" + txtHeader.text + "&p_thr_announcement_pk="  +  txtNewsPK.text + '&p_search_key=' + txtSearch_Key.text;
            var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
        }
    }   
    //----------------------
    function OnExport()
    {
        var url =System.RootURL + '/reports/ch/ae/rpt_announce_view_lb.aspx?p_header=' + txtHeader.text  + '&p_thr_announcement_pk=' + txtNewsPK.text + '&p_title=' + lbTitle.text  ;
        window.open(url); 
    }
</script>
<body>
    <gw:data id="datNews" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="2" type="control" parameter="0,9"  function="hr_sel_10010023_announcement" procedure="hr_upd_10010023_announcement"> 
                <inout>
                    <inout bind="lbCount" />
                    <inout bind="lbTitle" />
                    <inout bind="lbContent" />
                    <inout bind="lbWriter" />
                    <inout bind="lbDate" />
                    <inout bind="txtSQL" />
                    <inout bind="txtHeader" />
                    <inout bind="txtURL" />
                    <inout bind="txtSearch_Key" />
                    <inout bind="txtNewsPK" />
                </inout>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="datAnnounce_Data" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid"  function="hr_sel_10010023_announce_data">  
                <input bind="grdNews"   >  
                    <input bind="txtNewsPK" />
                </input> 
                <output bind="grdNews" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!------------------------------>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center" style="padding-top:20px;padding-right:0px">
                <table cellpadding="0" cellspacing="0" width="700px" style="border:1px solid;border-color:#333333">
                    <tr>
                        <td align="left" style="padding: 10px 10px 10px 10px">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td valign="middle" align="left" style="padding-left :10px; font-size:18px" colspan="4">
                                       <gw:label id="lbTitle" />
                                    </td>
                                </tr>
                                <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="4"></td></tr>
                                <tr style="height:18px">
                                    <td width="30%" valign="middle" align="left" style="padding-left:10px;white-space: nowrap">
                                        Date Post : <gw:label id="lbDate" />
                                    </td>
                                    <td  width="45%" align="right" style="display:inline">
                                    </td>
                                    <td  width="20%" align="right" style="display:inline">
                                        Count view :
                                    </td>
                                    <td width="5%" style="padding-left:5px">
                                        <gw:label id="lbCount"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="padding-top:15px">
                                        <gw:label id="lbContent"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="padding-top:15px">
                                        <div id="header"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" >
                                        <div id="grid"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="padding-top:10px" align=center>
                                        <div id="paging"></div>
                                    </td>
                                </tr>
                                <tr><td style="height:2px solid;background-color:#0363b2" valign="bottom" colspan="4"></td></tr>
                                <tr>
                                    <td align="left" style="padding-top:5px">
                                        <table cellpadding="0" cellspacing="0">
                                            <td style="padding-left:5px"></td>
                                            <td style="padding-left:5px"><gw:imgbtn id="btnCancel" img="cancel" alt="Close" text="Cancel" onclick="OnRedirect('chae00230_list.aspx?tp='+'<%=request.QueryString("tp")%>')"  /></td>
                                        </table>
                                    </td>
                                      <td align="center" colspan=1 style="padding-top:5px;padding-right:25px">
                                        <gw:imgbtn id="btnReport" img="excel" alt="Export"  onclick="OnExport()"  />
                                    </td>
                                    <td id="link" align="right" style="padding-top:5px;padding-right:25px">
                                         <gw:imgbtn id="btnOpen" img="confirm" alt="Open"  onclick="OpenPopup(1)"  />
                                    </td>
                                    <td id="Td1" align="right" style="padding-top:5px;padding-right:25px">
                                         <gw:imgbtn id="btnPopup" img="popup" alt="Check"  onclick="OpenPopup(2)"  />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <gw:grid 
                    id="grdNews"
                    header="|||||||"
                    format="0|0|0|0|0|0|0"
                    editcol="0|1|1|1|1|1|1" 
                    widths="0|1500|2000|1200|3000|1000|0"
                    aligns="0|0|0|0|0|0|0" 
                    defaults="||||||" 
                    styles="width:100%; height:0" />
            </td>
        </tr>
    </table>
      
    <gw:textbox id="txtNewsPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsType" maxlen="100" styles='width:100%;display:none' />
     <gw:textbox id="txtSQL" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtHeader" maxlen="100" styles='width:100%;display:none'/>
    <gw:textbox id="txtURL" maxlen="100" text="" styles='width:100%;display:none'/>
    <gw:textbox id="txtSearch_Key" maxlen="100" text="" styles='width:100%;display:none'/>
    <gw:textbox id="lbWriter" maxlen="100" styles='width:100%;display:none' text=""/>
    <gw:textbox id="txtSQL_Report" maxlen="100" styles='width:100%;display:none' text=""/>


</body>
</html>
