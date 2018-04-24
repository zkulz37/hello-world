<!-- #include file="../../../system/lib/form.inc"  -->
<%@ Page Language="C#" %>
<%@ Import Namespace = "System.Data" %>
<%
string dso_id = Request["dso_id"].ToString();
string output_control = Request["output_control"].ToString();   
%>
<!--output_control: grid, data, col_index, function, procedure, grid_list-->
<html>
    <head>
        <title>System controls management - Popup</title>
        <script language="javascript">
            function BodyInit() {
               //var ctrl = document.getElementById("content");
                //ctrl.innerText ="";
            }
        </script>
    </head>
    <body  onload="BodyInit()">
        <div id="content" contenteditable="true" style="width:100%">
			<%=ESysLib.RenderControlHTMLEncode(dso_id,output_control) %>
		</div>
		
    </body>
</html>