<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
    <style type="text/css">
        a:link {color:#8e8e8e;text-decoration:none;font-weight:normal;}
	    a:visited {color:#8e8e8e;text-decoration:none;font-weight:normal;}
	    a:active {color:#8e8e8e;text-decoration:none;font-weight:normal;}
	    a:hover {color:#326da7;text-decoration:none;font-weight:bold}
	    .normals{font-family:Tahoma;font-size:11px;color:#8e8e8e;font-weight:normal;}
    </style>
  </head>
 <%ESysLib.SetUser("comm")%>
 <script>
    var pgSize = 5;
    var pgCurr = 1;
    var ttRecord = 0;
    function BodyInit(){
        OnInit();
    }
    function OnInit(){
        System.Translate(document); 
        txtNewsPK.text='<%=request.QueryString("tp")%>';
        dsoNews.Call("SELECT");
    }
    function BindGrid(){
        var i=1;
        if(grdNews.rows > 0)
        ttRecord = grdNews.rows-1;
        if(pgSize*pgCurr < ttRecord) ttRecord = pgSize*pgCurr;
        //alert(ttRecord);
        var strHTML='<table border="0" cellpadding="0" cellspacing="0" width="100%">';
            for(i=pgSize*(pgCurr-1)+1;i<=ttRecord;i++){
                //alert(i);alert(ttRecord);
                if(i%2==0)
                    strHTML += "<tr style='height:23px'>";
                else 
                    strHTML += "<tr style='height:23px'  bgcolor='f7f6f6'>";
                strHTML += "<td style='width:51px' align='center' class='normals'>" + grdNews.GetGridData(i,0) + "</td>";
                strHTML += "<td align='left' style='padding-left:2px'><a href='#' onclick='OnRedirect(\"agas0020_view.aspx?tp="+'<%=request.QueryString("tp")%>' + '&pk=' + grdNews.GetGridData(i,1) + '")\'>' + grdNews.GetGridData(i,5) +"</a>&nbsp;"+ grdNews.GetGridData(i,3) + "</td>";
                strHTML += "<td style='width:101px' align='center' class='normals'>" + grdNews.GetGridData(i,4) + "</td>";
                strHTML += "<td style='width:151px' align='center' class='normals'>" + grdNews.GetGridData(i,6) + "</td>";
                strHTML += "<td style='width:71px' align='center' class='normals'>" + grdNews.GetGridData(i,2) + "</td>";
                strHTML += "</tr>";
            }
         strHTML += "</table>";
         var obj = document.getElementById("grid");
         obj.innerHTML = strHTML;
         BindPaging();
    }
    function BindPaging(){
        var ttPage=1;
        var ttrc = grdNews.rows-1;
        if(ttrc%pgSize==0)ttPage = ttrc/pgSize;
        else ttPage = ttrc/pgSize + 1;
        var strHTML='<table border="0" cellpadding="0" cellspacing="0"><tr>';
            for(var i = 1; i <= ttPage; i++){
                  strHTML += "<td style='width:20px' align='center' class='normals'>";
                  if(pgCurr == i)
                    strHTML += "<span style='font-weight:bold;color:#0363b2'>[" + i + "]</span>";
                  else strHTML += "<a href='#' onclick='OnPaging("+i+")'>"+i+"</a>";
                  strHTML += "</td>";
            }
        strHTML += "</tr></table>";
        var obj = document.getElementById("paging");
         obj.innerHTML = strHTML;
    }
    function OnPaging(pg){
        pgCurr = pg;
        BindGrid();
    }
    function OnRedirect(page){
        var lc = location.href;
        var arr = lc.split("/");
        lc = "";
        for(var x=0; x<arr.length-1; x++){
            lc += arr[x] + "/";
        }
        location.href = lc + page;
    }
    function OnSubmit(){
        
    }
    function OnDataReceive(obj){
       if(obj.id == "dsoNews")
            BindGrid();
    }
    function OnDataError(oData){
    }
</script>
<body>
    <gw:data id="dsoNews" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,7" function="comm.sp_sel_agas0020_type">  
                <input bind="grdStudent"   >  
                    <input bind="txtNewsPK" />  	 															
                </input> 
                <output bind="grdNews" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!------------------------------>
    <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
            <td align="center" style="padding-top:20px;padding-right:0px">
                <table cellpadding="0" cellspacing="0" width="700px" style="border:1px solid;border-color:#333333">
                    <tr>
                        <td align="left" style="padding: 10px 10px 10px 10px;background-color:#ffffff">
                            <table cellpadding="0" cellspacing="0" width="100%" style="height:400px" border="0">
                                <tr>
							        <td colspan="3" valign="top">
								        <table border="0" cellpadding="0" cellspacing="0" width="100%">
								            <tr>
								                <td style="font-family:Tahoma;font-size:14px;font-weight:normal;padding-left:10px;padding-top:3px" valign="middle"><img src="sin_btn_more03.gif" border="0" valign="absbottom" /> <span style="color:#326da7">WHAT'S</span> <span style="color:#a9a9a9"><%=Request.QueryString("tp").ToUpper()%></span></td>
								                <td style="padding-left:5px;padding-bottom:5px" align="right" valign="middle"><gw:imgbtn id="btnNew" img="new" alt="New" text="new" onclick="OnRedirect('agas0020.aspx?tp=<%=request.QueryString("tp")%>')" /></td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr>
								                <td height="23px" valign="top" colspan="2">
								                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
								                        <td style="width:1px" valign="top"><table cellpadding="0" cellspacing="0" width="1px" style="height:5px"><tr><td bgcolor="#10438A"></td></tr></table></td>
								                        <td style="width:50px;padding-top:2px" align="center">No.</td>
								                        <td style="width:1px" valign="top"><table cellpadding="0" cellspacing="0" width="1px" style="height:5px"><tr><td bgcolor="#10438A"></td></tr></table></td>
								                        <td style="padding-top:2px" align="center">Title</td>
								                        <td style="width:1px" valign="top"><table cellpadding="0" cellspacing="0" width="1px" style="height:5px"><tr><td bgcolor="#10438A"></td></tr></table></td>
								                        <td style="width:100px;padding-top:2px" align="center">Date Post</td>
								                        <td style="width:1px" valign="top"><table cellpadding="0" cellspacing="0" width="1px" style="height:5px"><tr><td bgcolor="#10438A"></td></tr></table></td>
								                        <td style="width:150px;padding-top:2px" align="center">Author</td>
								                        <td style="width:1px" valign="top"><table cellpadding="0" cellspacing="0" width="1px" style="height:5px"><tr><td bgcolor="#10438A"></td></tr></table></td>
								                        <td style="width:70px;padding-top:2px" align="center">Counter</td>
								                        <td style="width:1px" valign="top"><table cellpadding="0" cellspacing="0" width="1px" style="height:5px"><tr><td bgcolor="#10438A"></td></tr></table></td>
								                    </table>
								                </td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr><td style="height:5px" colspan="2"></td></tr>
								        </table>
								        <div id="grid"></div>
								        <table border="0" cellpadding="0" cellspacing="0" width="100%">
								            <tr><td style="height:5px" colspan="2"></td></tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								            <tr>
								                <td height="20px" valign="middle" align="center">
								                    <div id="paging"></div>
								                </td>
								            </tr>
								            <tr><td style="height:1px solid;background-color:#0363b2" valign="absbottom" colspan="2"></td></tr>
								        </table>
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
                    format="0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0" 
                    defaults="||||||" 
                    editcol="0|1|1|1|1|1|1" 
                    widths="0|1500|2000|1200|3000|1000|0"
                    styles="width:100%; height:100%;display:none" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtNewsPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtData" styles='width:100%;display:none' />
</body>
</html>
