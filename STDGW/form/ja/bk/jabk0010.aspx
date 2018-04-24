<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>M/R ENTRY</title>
</head>
<%  ESysLib.SetUser("PROD")%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

var G1_PK           = 0,
    G1_Booking_PK   = 1,
    G1_Item_PK      = 2,
    G1_ID           = 3,
    G1_Name         = 4,
    G1_Quatity      = 5,
    G1_Description  = 6;
    
var G2_PK           = 0, 
    G2_booking_pk   = 1,
    G2_tcm_caddy_pk = 2,
    G2_ID           = 3,
    G2_Full_Name    = 4,
    G2_Description  = 5;

//======================================================================

function OnToggle(pos)
{
    
}
//======================================================================
function OnCheck(pos)
{
    switch(pos)
    {
        case'chkWaiting':
            if(chkWaiting.value=='N')
            {
                lstTime02.SetEnable(false);
            }
            if(chkWaiting.value=='Y')
            {
                lstTime02.SetEnable(true);
            }
        break;
        
        case'chkSlipt':
            if(chkSlipt.value=='N')
            {
                txtSplitGroup.SetEnable(false);
            }
            if(chkSlipt.value=='Y')
            {
                txtSplitGroup.SetEnable(true);
            }
        break;
    }
}
//======================================================================

function BodyInit()
{
     BindingDataList();          
}
//============================================================================== 

 function BindingDataList()
 {      
     var data ;

     data = "data|1|06:00|2|07:00|3|08:00||";
     lstTime01.SetDataText(data);  
     lstTime02.SetDataText(data); 
     
     data = "data|1|Main|2|Second||";
     lstGolfType.SetDataText(data);    
     
     data = "data|1|18|2|36||";
     lstHoles.SetDataText(data); 
     
      var data = "<%=ESysLib.SetListDataSQL(" SELECT  pk, id || ' - ' || name from crm.TCM_MEMBER_TYPE where del_if = 0 order by id ")%>";     
      lstMemberType.SetDataText(data);                                
 }

 //===================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Booking' :
            data_jabk0010_1.StatusInsert();
        break;
    }
}  
 //===================================================================================
 var p_update ;
 
 function OnSave(pos)
 {
    switch(pos)
    {
        case 'Booking' :
            p_update = 'update' ;
            
            data_jabk0010_1.Call();
        break;
    }
 }
 
 //===================================================================================
function OnSearch(pos)
{ 
    switch (pos)
    {
       case 'Booking':
            var path = System.RootURL + "/form/ja/bk/jabk0011.aspx";
            var object = System.OpenModal( path ,700 , 550 ,  'resizable:yes;status:yes', this);     

            if ( object != null )
             {
                    data = object[0];                                                 
                    txtMasterPK.text = data[0];
                    data_jabk0010_1.Call("SELECT");                
             }         
                                     
       break;
       
       case 'Caddy':
            var path = System.RootURL + "/form/ja/rc/jarc0010_caddy.aspx";
            var object = System.OpenModal( path ,700 , 550 ,  'resizable:yes;status:yes', this);  
            
             if ( object != null )
             {
                    for ( var i=0; i< object.length; i++)
                    {
                        data = object[i];
                        
                        grdCaddy.AddRow();
                                                    
                        grdCaddy.SetGridText( grdCaddy.rows-1, G2_booking_pk, txtMasterPK.text );
                        grdCaddy.SetGridText( grdCaddy.rows-1, G2_tcm_caddy_pk, data[0] );
                        grdCaddy.SetGridText( grdCaddy.rows-1, G2_ID,           data[1] );
                        grdCaddy.SetGridText( grdCaddy.rows-1, G2_Full_Name,    data[2] );
    
                        grdCaddy.SetCellBgColor( grdCaddy.rows-1, 1 , grdCaddy.rows-1, 5, 0xCCFFFF );                                                                         
                    }                 
             }                           
               
       break;   
       
       case 'Item':
            var path = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=|Y||||";
            var object = System.OpenModal( path ,700 , 550 ,  'resizable:yes;status:yes', this);
            
             if ( object != null )
             {
                    for ( var i=0; i< object.length; i++)
                    {
                        data = object[i];
                        
                        grdRental.AddRow();
                                                    
                        grdRental.SetGridText( grdRental.rows-1, G1_Booking_PK, txtMasterPK.text );
                        grdRental.SetGridText( grdRental.rows-1, G1_Item_PK,    data[0] );
                        grdRental.SetGridText( grdRental.rows-1, G1_ID,         data[1] );
                        grdRental.SetGridText( grdRental.rows-1, G1_Name,       data[2] );
    
                        grdRental.SetCellBgColor( grdRental.rows-1, 1 , grdRental.rows-1, 6, 0xCCFFFF );                                                                         
                    }                 
             }                           
       break;            
    }   
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
   switch (obj.id)
   {
        case 'data_jabk0010_1' :
            if ( p_update == 'update' )
            {
                for ( var i=1; i<grdRental.rows-1;i++)
                {
                    if ( grdRental.GetGridData( i, G1_Booking_PK) == '' )
                    {
                        grdRental.SetGridText( i, G1_Booking_PK, txtMasterPK.text );
                    }    
                }
                            
                data_jabk0010_2.Call();
            }
            else
            {
                data_jabk0010_2.Call("SELECT");
            }
        break;
        
        case 'data_jabk0010_2' :
            if ( p_update == 'update' )
            {
                for ( var i=1; i<grdCaddy.rows-1;i++)
                {
                    if ( grdCaddy.GetGridData( i, G2_booking_pk) == '' )
                    {
                        grdCaddy.SetGridText( i, G2_booking_pk, txtMasterPK.text );
                    }    
                }
                
                data_jabk0010_3.Call();
            }
            else
            {
                data_jabk0010_3.Call("SELECT");
            } 
              
            p_update = '';     
        break;
   }
}

//==============================================================================
 function OnDelete(index)
 {        
    
}
//==============================================================================
 
function OnUnDelete()
{              
     
}
//==============================================================================
function OnCheckMember()
{
    data_jabk0010.Call("SELECT");
}
//==============================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3" function="crm.sp_sel_jabk0010" >
                <inout>
                    <inout bind="txtMemberID" /> 
                    <inout bind="lstMemberType" />     
                    <inout bind="txtMemberName" /> 
                    <inout bind="txtTelephone" />                    
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="crm.sp_sel_jabk0010_1" procedure="crm.sp_upd_jabk0010_1">
                <inout>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="txtMemberID" /> 
                    <inout bind="lstMemberType" />     
                    <inout bind="txtMemberName" /> 
                    <inout bind="txtTelephone" />                                        
                    <inout bind="txtNumberGuest" />
                    <inout bind="txtGroupNumber" />
                    <inout bind="chkSlipt" />                    
                    <inout bind="txtSplitGroup" />
                    <inout bind="checkIsTour" />                    
                    <inout bind="dtBookDate" />
                    <inout bind="lstTime01" />
                    <inout bind="chkWaiting" />
                    <inout bind="lstTime02" />
                    <inout bind="lstGolfType" />                    
                    <inout bind="lstHoles" />                                        
                    <inout bind="txtQuests" />                    
                    <inout bind="txtRemark" />                     
                    <inout bind="chkPutLongTime" /> 
                    <inout bind="dtBookToDate" />                                                      
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" parameter="0,1,2,3,4,5,6" function="crm.sp_sel_jabk0010_2" procedure="crm.sp_upd_jabk0010_2" > 
                <input> 
                    <inout bind="txtMasterPK" />                                   
                </input> 
                <output bind="grdRental" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0010_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" parameter="0,1,2,3,4,5" function="crm.sp_sel_jabk0010_3" procedure="crm.sp_upd_jabk0010_3" > 
                <input> 
                    <inout bind="txtMasterPK" />                                   
                </input> 
                <output bind="grdCaddy" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 10%; width: 100%">
            <td style="width: 100%" colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td colspan="5">
                            <table>
                                <tr>
                                    <td style="width: 95%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSearch1" img="search" alt="Search" text="Search" onclick="OnSearch('Booking')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnNew1" alt="Free Item" img="New" text="Add" onclick="OnAddNew('Booking')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDelete1" img="delete" alt="Delete" text="Delete" onclick="OnDelete(1)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete1" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete(0)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave1" img="save" alt="Save" text="Save" onclick="OnSave('Booking')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%">
                        <td style="width: 6%" align="left">
                            Member No.
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtMemberID" styles="width:50%" onenterkey="OnCheckMember()" />
                            <%--<gw:imgbtn id="ibtnSearch" alt="Search" text="Check"  />--%>
                            <gw:button id="btnCheckMember" text="Check" onclick="OnCheckMember()" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%" align="left">
                            Day
                        </td>
                        <td style="width: 11%" align="left">
                            <gw:datebox id="dtBookDate" lang="1" />
                        </td>
                    </tr>
                    <tr style="width: 100%">
                        <td style="width: 6%" align="left">
                            Member Type.
                        </td>
                        <td style="width: 10%">
                            <gw:list id="lstMemberType" styles="color:blue;width:80%" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%" align="left">
                            Time
                        </td>
                        <td style="width: 11%" align="left">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td align="left" style="width: 4%">
                                        <gw:list id="lstTime01" styles="color:blue;width:100%" />
                                    </td>
                                    <td align="left" style="width: 2%" colspan="2">
                                        <gw:checkbox id="chkWaiting" defaultvalue="Y|N" value="Y" onclick="OnCheck('chkWaiting')" />
                                        Waiting
                                    </td>
                                    <td align="left" style="width: 4%">
                                        <gw:list id="lstTime02" styles="color:blue;width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="width: 100%">
                        <td style="width: 6%" align="left">
                            <b style="color: Red">*</b> Full Name.
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtMemberName" styles="width:90%" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%" align="left">
                            Golf Type
                        </td>
                        <td align="left" style="width: 11%">
                            <gw:list id="lstGolfType" styles="color:blue;width:50%" />
                        </td>
                    </tr>
                    <tr style="width: 100%">
                        <td style="width: 6%" align="left">
                            Telephone.
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtTelephone" styles="width:90%" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%" align="left">
                            Holes
                        </td>
                        <td align="left" style="width: 11%">
                            <gw:list id="lstHoles" styles="color:blue;width:70%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%" colspan="2">
                <hr noshade size="4" style="color: Silver; width: 90%">
            </td>
        </tr>
        <tr style="height: 20%">
            <td style="height: 20%; width: 100%" colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%; width: 100%" align="left">
                        <td style="width: 16%" align="left">
                            Number Guest
                        </td>
                        <td style="width: 15%" align="left">
                            <gw:textbox id="txtNumberGuest" styles="width:100%" />
                        </td>
                        <td style="width: 12%" align="center">
                            Group Number
                        </td>
                        <td style="width: 8%; white-space: nowrap" align="left">
                            <gw:textbox id="txtGroupNumber" styles="width:100%" />
                            <gw:checkbox id="chkSlipt" defaultvalue="Y|N" value="Y" onclick="OnCheck('chkSlipt')" />
                        </td>
                        <td style="width: 12%" align="center">
                            Split Group
                        </td>
                        <td style="width: 7%" align="left">
                            <gw:textbox id="txtSplitGroup" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="left">
                            Is Tour
                            <gw:checkbox id="checkIsTour" defaultvalue="Y|N" value="N" />
                        </td>
                        <td style="width: 40%">
                        </td>
                    </tr>
                    <tr style="height: 1%; width: 100%" align="left">
                        <td style="width: 16%" align="left">
                            Guests
                        </td>
                        <td style="width: 60%" align="left" colspan="7">
                            <gw:textbox id="txtQuests" styles="width:70%" />
                        </td>
                    </tr>
                    <tr style="height: 1%; width: 100%" align="left">
                        <td style="width: 16%" align="left">
                            Description
                        </td>
                        <td style="width: 60%" align="left" colspan="7">
                            <gw:textbox id="txtRemark" styles="width:70%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%" colspan="2">
                <hr noshade size="2" style="color: Silver; width: 90%">
            </td>
        </tr>
        <tr style="height: 45%; width: 100%">
            <td style="width: 49%" align="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 95%" align="left">
                            Rental</td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew2" alt="Free Item" img="New" text="Add" onclick="OnSearch('Item')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete2" img="delete" alt="Delete" text="Delete" onclick="OnDelete(1)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete2" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete(0)" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%" colspan="6">
                            <gw:grid id='grdRental' header='_PK|_Booking_PK|_item_pk|ID|Name|Quatity|Description'
                                format='0|0|0|0|0|0|0' aligns='0|0|0|0|0|3|0' defaults='||||||' editcol='0|0|0|0|0|1|1'
                                widths='1000|1000|1500|1500|3000|1200|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 49%" align="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="left">
                            Caddy
                        </td>
                        <td style="width: 15%">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew3" alt="Free Item" img="New" text="Add" onclick="OnSearch('Caddy')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete3" img="delete" alt="Delete" text="Delete" onclick="OnDelete(1)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete3" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete(0)" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%" colspan="8">
                            <gw:grid id='grdCaddy' header='_PK|_booking_pk|_tcm_caddy_pk|ID|Full Name|Description'
                                format='0|0|0|0|0|0' aligns='0|0|0|0|0|0' defaults='|||||' editcol='0|0|0|0|0|1'
                                widths='1000|1000|1000|1500|3000|1000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%" colspan="2">
                <hr noshade size="4" style="color: Silver; width: 90%">
            </td>
        </tr>
        <tr style="height: 30%">
            <td colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="white-space: nowrap; width: 20%" align="left">
                            <gw:checkbox id="chkPutLongTime" defaultvalue="Y|N" value="N" />
                            Put Long Time
                        </td>
                        <td align="left" colspan="2" style="white-space: nowrap">
                            To Date
                            <gw:datebox id="dtBookToDate" lang="1" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            <gw:radio id="radTab" value="1" styles="width:100%"> 
                                <span value="1" id="Week">By Week</span>                                 
                            </gw:radio>
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:checkbox id="chkMon" defaultvalue="Y|N" value="N" />
                            Mon
                            <gw:checkbox id="chkTue" defaultvalue="Y|N" value="N" />
                            Tue
                            <gw:checkbox id="chkWed" defaultvalue="Y|N" value="N" />
                            Wed
                            <gw:checkbox id="chkThu" defaultvalue="Y|N" value="N" />
                            Thu
                            <gw:checkbox id="chkFri" defaultvalue="Y|N" value="N" />
                            Fri
                            <gw:checkbox id="chkSat" defaultvalue="Y|N" value="N" />
                            Sat
                            <gw:checkbox id="chkSun" defaultvalue="Y|N" value="N" />
                            Sun
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            <gw:radio id="radTab" value="1" styles="width:100%"> 
                                <span value="1" id="Day">By Day</span>                                 
                            </gw:radio>
                        </td>
                        <td style="white-space: nowrap" colspan="2">
                            <gw:textbox id="txtByDay" styles="width:100%" />
                        </td>
                        <td style="white-space: nowrap" align="left">
                            Example : 15, 30 ...
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
