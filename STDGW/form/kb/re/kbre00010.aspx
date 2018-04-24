<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>SPINNING INQUIRY</title>
</head>

<script type="text/javascript" language="javascript">

var G2_DATE        = 0,
    G2_PROD_QTY    = 1,
    G2_PLAN_QTY    = 2, 
    G2_ACTUAL_QTY  = 3,
    G2_C_B         = 4;
       
//------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
	
    //----------------------------
     var ctrl = grd_Result.GetGridControl();        
    ctrl.ColFormat(G2_PROD_QTY)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_PLAN_QTY)    = "###,###,###.##" ;
    ctrl.ColFormat(G2_ACTUAL_QTY)  = "###,###,###.##" ;
    
    OnSearch();  
}

//-------------------------------------------------------------------------------------
function OnSearch()
{
    data_kbre00010.Call("SELECT");   
           
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {   
         case "data_kbre00010":	
            lblRecord.text  = ( grd_Result.rows -1 )+ " record(s)."
         break; 
        
    }
}

//====================================================================================
    
</script>

<body>
     <!------------------------------------------------------------------>
    <gw:data id="data_kbre00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_kbre00010"  > 
                <input>
                    <input bind="dt_From_YMD" /> 
                    <input bind="dt_To_YMD" /> 
                </input> 
                <output bind="grd_Result" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <!---------------------------------------------------------------------->
    <table border="0" style="width: 100%; height: 100%">
        <tr>           
             <td style="width: 5%">
                Date
            </td>
            <td style="width: 20%; white-space:nowrap;">
                <gw:datebox id="dt_From_YMD" lang="1" />&nbsp;
                ~
                <gw:datebox id="dt_To_YMD" lang="1" />
            </td>
             <td style="width: 4%">
                
            </td>
             <td style="width: 35%" align="right">
                <gw:label id="lblRecord"  text="" styles="color:red"/>
            </td>
            <td style="width: 35%">
                
            </td>                       
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="6">
                <gw:grid id='grd_Result'
                    header='Date|Prod Qty (A)|Plan Accumulation Qty (B)|Actual Accumulation Qty (C)|C/B|'
                    format='4|1|1|1|1|0'
                    aligns='0|0|0|0|0|0'
                    check='|||||'
                    editcol='0|0|0|0|0|0'
                    widths='1500|1200|2500|2500|1500|1000'
                    sorting='T'
                    styles='width:100%; height:100%'
                    />
            </td>
        </tr>
    </table>
</body>
</html>
