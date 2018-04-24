<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Golfer Information</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var PK                      = 0,
    NO                      = 1,
    TCM_MEMBER_TYPE_PK      = 2,
    MEMBER_ID               = 3,
    GOLFER_NAME             = 4,
    CARD_NO                 = 5,
    BAG_NO                  = 6,
    CHECKIN                 = 7,
    GROUP_NO                = 8,
    COURSE_NAME             = 9,
    TEE_TIME                = 10;

function  BodyInit()
{   
  InitForm();
  InitData();
}
function InitForm(){
    txtGroup.SetEnable(false);
    txtCourse.SetEnable(false);
    txtTeeTime.SetEnable(false);
}
function InitData(){
    var data="";
    data = "<%=ESysLib.SetGridColumnDataSQL("select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and a.USE_YN ='Y' order by a.NAME" )%>"; 
	grdGolfer.SetComboFormat(TCM_MEMBER_TYPE_PK, data);

    txtPK.text = '<%=Request.QueryString("pk") %>';
    data_jarc00040_golfer.Call("SELECT");
    //grdGolfer.SetComboFormat(ITEM, "#10;GREEN FEE|#20;CADDY FEE|#30;CART FEE|#40;F&B FEE|#50;GOLFBAG FEE");
}
function OnSave(){
    if(CheckSaveValid())
        data_jarc00040_golfer.Call(); 
}
function OnGolferDouble()
{
    if((event.col == MEMBER_ID && event.row > 0))
    {
        var path = System.RootURL + "/form/ja/rc/jarc0010_member.aspx";
         var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
         if ( object != null )
         {
              var arrTemp
              arrTemp = object[0];
              grdGolfer.SetGridText(grdGolfer.row,  MEMBER_ID           ,arrTemp[1])//member Id
              grdGolfer.SetGridText(grdGolfer.row,  GOLFER_NAME         ,arrTemp[2])//member name
              grdGolfer.SetGridText(grdGolfer.row,  TCM_MEMBER_TYPE_PK  ,arrTemp[13])//member pk
         }
    }      
}
 function OnAfterCellEdit(obj){
    if(obj.id == "grdGolfer")
    {
        if(event.col == MEMBER_ID){
            txtTmpMemberID.text = obj.GetGridData(event.row, MEMBER_ID);
            if(txtTmpMemberID.text != ""){
                dsoLookupMember.Call("SELECT");
            }
        }
    }
 }
 function OnGetMember(p_member_id)
 {
         var path = System.RootURL + "/form/ja/rc/jarc0010_member.aspx?member_no="+p_member_id;
	         var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              grdGolfer.SetGridText(grdGolfer.row,  MEMBER_ID           ,arrTemp[1])//member Id
	              grdGolfer.SetGridText(grdGolfer.row,  GOLFER_NAME         ,arrTemp[2])//member name
	              grdGolfer.SetGridText(grdGolfer.row,  TCM_MEMBER_TYPE_PK  ,arrTemp[13])//member pk
	         }
 }  
function CheckSaveValid()
{
	for (var i = 1; i < grdGolfer.rows; i++){
	
		if(grdGolfer.GetGridData(i, PK)             == ""){
		    alert('Please, input member type in grid!'); return false;}
		
		if(grdGolfer.GetGridData(i, GOLFER_NAME)    ==""){
		    alert('Please, input player name in grid!'); return false;}
		    
        if(grdGolfer.GetGridData(i, BAG_NO)         ==""){
            alert('Please, input bag tag number!'); return false;}
            
        if(grdGolfer.GetGridData(i, CARD_NO)        ==""){
            alert('Please, input locker number!'); return false;}
    }
    return true;
}
function OnDataReceive(obj){
    switch(obj.id){
        case "data_jarc00040_golfer":
            if (grdGolfer.rows >1)
            {
                txtGroup.text   = grdGolfer.GetGridData(1,GROUP_NO);
                txtCourse.text  = grdGolfer.GetGridData(1,COURSE_NAME);
                txtTeeTime.text = grdGolfer.GetGridData(1,TEE_TIME);
		        grdGolfer.SetCellBgColor( 1, MEMBER_ID      , grdGolfer.rows - 1, MEMBER_ID     , 0xCCFFFF );
		        grdGolfer.SetCellBgColor( 1, GOLFER_NAME    , grdGolfer.rows - 1, GOLFER_NAME   , 0xCCFFFF );
		        grdGolfer.SetCellBgColor( 1, CARD_NO        , grdGolfer.rows - 1, CARD_NO       , 0xCCFFFF );
            }
        break;
        case "dsoLookupMember":
            if(grdMemberList.rows == 2){
                grdGolfer.SetGridText(grdGolfer.row ,MEMBER_ID          ,grdMemberList.GetGridData(1,0));
                grdGolfer.SetGridText(grdGolfer.row ,GOLFER_NAME        , grdMemberList.GetGridData(1,1));
                grdGolfer.SetGridText(grdGolfer.row ,TCM_MEMBER_TYPE_PK , grdMemberList.GetGridData(1,2));
           }
           else{
                OnGetMember(txtTmpMemberID.text);
           }
        break;
    }
}
</script>
<body>
    <gw:data id="dsoLookupMember" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3" function="CRM.sp_sel_jarc0010_lkp_member" > 
                <input> 
                    <input bind="txtTmpMemberID" /> 
                </input> 
                <output bind="grdMemberList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <gw:data id="data_jarc00040_golfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,2,3,4,5,6" function="crm.sp_sel_jarc00040_golfer" procedure="crm.sp_upd_jarc00040_golfer">
                <input>
                    <input bind="txtPK" />
                </input>
                <output bind="grdGolfer" />
            </dso>
        </xml>
    </gw:data>
    <table style="width: 100%; height: 100%" border="0">
        <tr valign="top" style="height: 2%">
            <td align="center" colspan="4">
                <table style="height: 100%; width: 100%">
                    <tr style="height:20px;">
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;width:50px;">Group</td>
                        <td><gw:textbox id="txtGroup" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;width:50px;">Course</td>
                        <td><gw:textbox id="txtCourse" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;width:60px;">Tee Time</td>
                        <td><gw:textbox id="txtTeeTime" styles="width:100%" /></td>
                        <td style="width:50px"><gw:icon id="idBtnSave" img="2" text="Save" styles='width:100%' onclick="OnSave()" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height:100%" colspan="4">
                <gw:grid id='grdGolfer' 
                    header  ='_pk|No#|Player Type|Member ID#|Player Name|Locker#|Bagtag#|Check In|_Group_No|_Course_Name|_Tee_Time'
                    format  ='0|0|0|0|0|0|0|0|0|0|0' 
                    aligns  ='0|0|0|0|0|0|0|0|0|0|0' 
                    editcol ='0|0|0|1|1|1|1|0|0|0|0'
                    check   ='|||||||||'
                    autosize='T' 
                    sorting ='T' 
                    styles  ='width:100%; height:100%'
                    oncelldblclick="OnGolferDouble()"
                    onafteredit="OnAfterCellEdit(this)"
                />
            </td>
        </tr>
    </table>
    <gw:grid id='grdMemberList' header='MemberID|Name|Member Type' format='0|0|0'  styles='display:none' />
    <gw:textbox id="txtPK" styles="width:100%; display:none" />
    <gw:textbox id="txtTmpMemberID" text="" styles="display:none" />
    <!------------------------------------------------------------------------>
</body>
</html>
