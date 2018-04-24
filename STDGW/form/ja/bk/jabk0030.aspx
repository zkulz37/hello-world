<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BOOKING ENTRY</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

var G_PK            =0,
    G_MEMBER_ID     =1,
    G_CUSTOMER      =2,
    G_TIME          =3;
    

var G3_pk               =0,
    G3_SEQ              =1,
    G3_GROUP_ID         =2,
    G3_ID               =3,
    G3_Member_Type      =4,
    G3_Name             =5,
    G3_GENDER           =6,
    G3_MOBILE_PHONE     =7,
    G3_START_HOLE       =8,
    G3_TCM_Caddy_PK     =9,
    G3_Caddy_ID         =10,
    G3_Caddy_Name       =11,
    G3_BookCart         =12,
    G3_BookGolfbag      =13,
    G3_BookShoes        =14,
    G3_DESCRIPTION      =15,
    G3_TCM_BOOKING_PK   =16,
    G3_Member_PK        =17;
    
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
//==============================================================================
function BodyInit()
{
    // OnToggle();//alert("111")
     BindingDataList(); 
     txtMemberName.SetEnable(false);
     txtCreateBy.SetReadOnly(true);
     txtCreateDate.SetReadOnly(true); 
	 data = "DATA|02|CASH|01|CREDIT CARD GUARANTEE||"; 
	 lstGTDType.SetDataText(data);
	 lstGTDType.value='';
	 data = "DATA|01|VISA|02|MASTER|03|AMERICAN EXPRESS"; 
	 lstCreditType.SetDataText(data); 
	 HideShowControl();
     OnAddNew('Booking');
	 data_jabk0030.Call("SELECT");
     
}
//======================================================================
function OnCheckCustomer(obj_popup)
{
    if(obj_popup=='2')
	{
		var path = System.RootURL + '/form/ja/bk/jabk0031.aspx';
		var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

		 if ( obj != null )
		 {
			 txtBusPartnerPK.text = obj[0]; 
			 txtMemberName.text   = obj[4];
			 txtTelephone.text = obj[10];
			 if(grdGolfer.rows == 1)
			 {
				 grdGolfer.AddRow();
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_SEQ, grdGolfer.rows-1 );
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_Name, txtMemberName.text );
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_ID, txtIDPastport.text );
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_MOBILE_PHONE, txtTelephone.text );
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_GENDER, txtGender.text );
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_AGE, txtAge.text );
				 grdGolfer.SetGridText( grdGolfer.rows-1, G3_Member_PK, txtMemberPK.text );
			 }
		 }  
	}
	if(obj_popup=='1')
	{
		var path = System.RootURL + '/form/ja/bk/jabk0031.aspx';
		var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

		 if ( obj != null )
		 {
			txtCompanyPK_S.text = obj[0]; 
			txtCompanyNameS.text   = obj[4];
			OnSearch('BookingList');
		}
	}
    
}
//============================================================================== 

 function BindingDataList()
 {      
     var data ;
     
     data = "<%=ESysLib.SetListDataSQL(" SELECT  pk, COURSE_ID || ' - ' || COURSE_NAME from crm.tgm_golf_course where del_if = 0 and ACTIVE_YN='Y' order by COURSE_ID ")%>"+"||";
     lstGolfType.SetDataText(data);    
     lstGolfType.value="";
     data = "data |9|9|18|18|27|27|36|36";
     lstHoles.SetDataText(data); 
     
      var data = "<%=ESysLib.SetListDataSQL(" SELECT  pk, id || ' - ' || name from crm.TCM_MEMBER_TYPE where del_if = 0 order by id ")%>";     
      lstMemberType.SetDataText(data);
      //data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm FROM hr.thr_code_detail a, hr.thr_code_master b WHERE a.del_if = 0 AND a.thr_code_master_pk = b.pk AND b.ID = 'HR0007'" )%>";
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>";
      grdGolfer.SetComboFormat(G3_GENDER,data);
      grdGolfer.SetComboFormat(G3_GROUP_ID,'#1;A|#2;B|#3;C');
      data = "data|10|Confirmed|20|Waiting|30|Cancelled|40|Tentative";
      lstStatus.SetDataText(data); 
      lstStatus.value=10;
      lstStatus1.SetDataText(data); 
      lstStatus1.value=10;
      data = "<%=ESysLib.SetGridColumnDataSQL("select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and nvl(a.USE_YN,'N')='Y'  order by a.NAME" )%>"; 
	  grdGolfer.SetComboFormat(G3_Member_Type,data); //Member type 
	  //PK|No|Group#|Member#|*Member Type|*Player Name|Gender|Mobile Phone|Start Hole|_TCM_Caddy_pk|Caddy#.|Caddy Name|Book Cart|Remark|_TCM_BOOKING_PK|_Member_pk
	  var data = "<%=ESysLib.SetListDataSQL(" select to_char((sysdate),'yyyymmdd') booking_value,to_char((sysdate),'yyyymmdd') booking_name from dual")%>";     
      lstDateBooking.SetDataText(data);
        
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	  grdGolferProfile.SetComboFormat(3,data);
	  data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" ) %> "; 
	  grdGolferProfile.SetComboFormat(5,data); 
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" )%>"; 
	lstNation.SetDataText(data);
	lstNation.value = 'NAT-VIE';	
	 // btnNew4.SetEnable(false); //addnew detail golfer	  
 }
//===================================================================================
 function OnHoleChange(){
    var arrayHole = '';
    for(var x = 1; x <= lstHoles.value; x++)
        arrayHole += '|' + x + ';' + x;
    grdGolfer.SetComboFormat(G3_START_HOLE, arrayHole);
 }
//===================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Booking' :
            data_jabk0030_1.StatusInsert();
            lstHoles.value="";
            grdGolfer.ClearData();
            
            btnSave1.SetEnable(true);
            //btnSave4.SetEnable(false); 
        break;
        
        case 'grdGolfer':
            if(checkShortGun.value == 'N')
                if(grdGolfer.rows > 4){alert('Player list limit 4 person!');return false;}
            grdGolfer.AddRow();
            grdGolfer.SetGridText( grdGolfer.rows-1, G3_TCM_BOOKING_PK, txtMasterPK.text);
            grdGolfer.SetGridText( grdGolfer.rows-1, G3_SEQ, grdGolfer.rows-1 );
            grdGolfer.SetGridText(grdGolfer.rows-1,G3_Member_Type, 7);
            for(var i=1;i<grdGolfer.rows-1;i++)
             {
                if(grdGolfer.GetGridData(i,2) !="")
                    {
                            grdGolfer.SetGridText(grdGolfer.rows-1,G3_Member_Type, 6);//add member type pk
                    }
              }/**/
        break;
    }
}
//===================================================================================
 function CheckInput(pos)
 {
   if(pos == "grdGolfer")
    {
        if(event.col == G3_ID){
            txtTmpMemberID.text = grdGolfer.GetGridData(event.row,G3_ID);
            if(txtTmpMemberID.text != ""){
                dsoLookupMember.Call("SELECT");
            }
        }
    } 
} 
 //===================================================================================
 function CheckDataSave(pos)
 {
    switch(pos)
    {
        case'Booking':
            
            if ( dtBookDate.GetData() == "" )
            {
                alert("Please select play date.");
                return false;
            }
			if ( lstGolfType.GetData() == "" )
            {
                alert("Please select course.");
                return false;
            }
            if ( txtContactor.text == "" )
            {
                alert("Please input contact person !!!");
                return false;
            }
            if((!Number(txtNumberGuest.text))&&(txtNumberGuest.text!=""))
            {
                alert("Please Input Numberic");
                return false;
            }
            if((!Number(txtGroupNumber.text))&&(txtGroupNumber.text!=""))
            {
                alert("Please Input Numberic")
                return false;
            }
            if(txtTime.text=="")
            {
                alert("Please choose time to play");
                return false;
            }
            if(lstHoles.value=="")
            {
                alert("Please choose holes");  
                return false;
            }
            if(lstHoles.value =="")
            {
                alert("Please input hole");
                return false;
            }
            return true;
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
            
            if(CheckDataSave('Booking'))
            {
			    p_update = 'update' ;
                data_jabk0030_1.Call();
            }                      
        break;
        
        case 'grdGolfer':
            if(txtMasterPK.text!="")
            {   
                for ( var i=1; i<grdGolfer.rows-1;i++)
                {
                    if ( grdGolfer.GetGridData( i, G3_TCM_BOOKING_PK) == '' )
                    {
                        grdGolfer.SetGridText( i, G3_TCM_BOOKING_PK, txtMasterPK.text );
                    }    
					
                }
                p_update = 'update';
                
                data_jabk0030_2.Call();
            }
            else
            {
                alert ("Please Save Customer Frist");
            }    
        break;
        
             

    }
 }
 
 //===================================================================================
function OnSearch(pos)
{ 
    switch (pos) 
    {
       case 'BookingList':
            data_jabk0030.Call('SELECT');
       break;
       
       case'2':
            txtMasterPK.text=grdBookingList.GetGridData(grdBookingList.row,G_PK);
            p_update = "";
            data_jabk0030_1.Call('SELECT');
       break;
       
       case 'Booking':
            var path = System.RootURL + "/form/ja/bk/jabk0011.aspx";
            var object = System.OpenModal( path ,700 , 550 ,  'resizable:yes;status:yes', this);     

            if ( object != null )
             {
                    data = object[0];                                                 
                    txtMasterPK.text = data[0];
                    data_jabk0030_1.Call("SELECT");                
             }         
                                     
       break;
       
     
    }   
}
//============================================================================
function ResetControl()
{
       txtMasterPK.text="";
       txtMemberID.text="";
       lstMemberType.value="";  
       txtMemberName.text="";
       txtTelephone.text="";                                       
       txtNumberGuest.text="";
       txtGroupNumber.text="";
       chkSlipt.value="N"    ;           
       checkShortGun.value="N"                   
       dtBookDate.value=dtDateToday.value;
       txtTime.text="";
       //lstGolfType.value="";                  
       lstHoles.value="";                                                          
       txtRemark.text="";
       txtBusPartnerPK.text="";
       txtIDPastport.text="";
       txtGender.text=""; 
       txtAge.text="";
       txtMemberPK.text="";
}
//==============================================================================
function OnDataReceive(obj)
{
   switch (obj.id)
   {
        case 'data_jabk0030_1' :

            if ( p_update == 'update' || p_update == 'delete')
            {
                if(p_update == 'update')
				{
					for ( var i=1; i<grdGolfer.rows;i++)
					{  
						if ( grdGolfer.GetGridData( i, G3_TCM_BOOKING_PK) == '' )
						{
							grdGolfer.SetGridText( i, G3_TCM_BOOKING_PK, txtMasterPK.text );
						   
						}    
						grdGolfer.SetGridText( i, G3_SEQ, i );
					}
					
					data_jabk0030_2.Call(); 
				}
				else
				{
					p_update == 'stop'
					data_jabk0030.Call('SELECT');
				}
            }
            else
            {
                HideShowControl();
				data_jabk0030_2.Call('SELECT');
            }
            if(txtMasterPK.text=="")
            {  
                //btnSave4.SetEnable(false);  
            }else
            {
               //btnSave4.SetEnable(true);  
            }
        break;
        
        case 'data_jabk0030_2' :
            lblTotalRow.text = grdGolfer.rows-1;
            if(dtBookDate.value < lstDateBooking.value)
            {
                btnSave1.SetEnable(false); 
                //btnSave4.SetEnable(false);
            }
            else
            {
                btnSave1.SetEnable(true);
                //btnSave4.SetEnable(true);
            }
                
            OnHoleChange();
        break;
        
        case 'data_jabk0030_3':
            if(p_update == 'update')
            {
                data_jabk0030.Call("SELECT");
                p_update='';
            }
        break;

        case 'data_jabk0030_5':
            
            if(txtMemberID.text!="")
            {
                grdGolfer.AddRow();
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_SEQ, grdGolfer.rows-1 );
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_Name, txtMemberName.text );
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_ID, txtIDPastport.text );
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_MOBILE_PHONE, txtTelephone.text );
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_GENDER, txtGender.text );
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_AGE, txtAge.text );
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_Member_PK, txtMemberPK.text );
            }
            else
            {
                alert("Not found ID: " +ss+" , Please check again");
            }
        break;
		case 'data_jabk0030' :
		grdBookingList.GetGridControl().TopRow = grdBookingList.rows-1;
		lblRows.text = grdBookingList.rows-1;
		break;
		case "dsoLookupMember":
           if(grdMemberList.rows == 2){
                grdGolfer.SetGridText(grdGolfer.row,G3_ID, grdMemberList.GetGridData(1,0));
                grdGolfer.SetGridText(grdGolfer.row,G3_Name, grdMemberList.GetGridData(1,1));
                grdGolfer.SetGridText(grdGolfer.row,G3_Member_Type, grdMemberList.GetGridData(1,2));
           }
           else if(grdMemberList.rows == 1){
                alert("You type invalid member id.");
           }
           else{
                OnGetMember(txtTmpMemberID.text);
           }
        break;
		case "dso_pro_jabk0030_copy":
			 alert("Copy data was completed.");
			 lstStatus1.value=20;
			  data_jabk0030_1.Call('SELECT');

        break;
   }
}

//==============================================================================
 function OnDelete(index)
 {
    switch(index)
    {
        case'Booking':
            if(confirm('Are you sure to delete ?'))
            {
            data_jabk0030_1.StatusDelete();
			p_update = 'delete';
            data_jabk0030_1.Call();
            }
        break;
        case'grdGolfer':
            if(grdGolfer.GetGridData( grdGolfer.row, G3_pk ) == ""&&grdGolfer.GetGridData( grdGolfer.row, G3_Member_PK ) == "" )
            {
                grdGolfer.RemoveRow();	
            }        			
			else if(grdGolfer.row> 0) 
	        {  
			   if(confirm("Do you want to delete these data?"))
			   {
					grdGolfer.DeleteRow();
					data_jabk0030_2.Call();			
			   }
	        }
        break;
        

    }        
    
}
//==============================================================================
 
function OnUnDelete(pos)
{              
     switch(pos)
     {
        case'Booking':
            data_jabk0030_1.StatusUpdate();
        break;
        
     }
}
//==============================================================================
var ss="";
function OnCheckMember()
{
    var member =txtMemberID.text;
    
    if(data_jabk0030_1.GetStatus() != 20)
    {
        data_jabk0030_1.StatusInsert();
    }   
    
    txtMemberID.text=member;
    grdGolfer.ClearData();
    
    data_jabk0030_5.Call("SELECT");
    ss=txtMemberID.text;
}
//==============================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case'time':
            if ( dtBookDate.GetData() == "" )
            {
                alert("Please select play date firstly.");
                return false;
            }
			if ( lstGolfType.GetData() == "" )
            {
                alert("Please select course firstly.");
				lstGolfType.GetControl().focus();
                return false;
            }
			var golf_course;
			//keep teetime sheet the same as IO
			if(lstGolfType.value == 4)
			{
				golf_course = 2;
			}
			else if(lstGolfType.value == 5)
			{
				golf_course = 1;
			}
			else
			{
				golf_course=lstGolfType.value;
			}
            var path = System.RootURL + "/form/ja/bk/jabk0035.aspx?golf_type=" + golf_course + "&day=" + dtBookDate.value + "";
            var obj = System.OpenModal( path ,730 , 500,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                  txtTime.text = obj[0];
                  dtBookDate.value=obj[1];
            }
        break;
        case'member':
            var path = System.RootURL + '/form/ja/bk/jabk0034.aspx';
            var object = System.OpenModal( path , 600 , 400 ,  'resizable:yes;status:yes');
            if(object!= null)
            {
                  txtMemberID.text= object[0];
            } 
        break;
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
	              			  
				    grdGolfer.SetGridText(grdGolfer.row,G3_ID,arrTemp[1])//id
                    grdGolfer.SetGridText(grdGolfer.row,G3_Name,arrTemp[2])//name
                    //grdGolfer.SetGridText(grdGolfer.row,G3_MOBILE_PHONE,object[3])//phone
                    grdGolfer.SetGridText(grdGolfer.row,G3_GENDER,arrTemp[4])//gender
                    grdGolfer.SetGridText(grdGolfer.row,G3_Member_Type,arrTemp[13])//member type
                    grdGolfer.SetGridText(grdGolfer.row,G3_Member_PK,arrTemp[0])//member pk
	         }
 }   

//==============================================================================
function OnGridCellDblClick()
{
    var event_col = event.col;
    var event_row = event.row;
    if ( event_col == G3_Caddy_ID ||event_col== G3_Caddy_Name )
        {    
             var path = System.RootURL + '/form/ja/bk/jabk0033.aspx';
             var object = System.OpenModal( path , 500 , 300 ,  'resizable:yes;status:yes');
             if(object!= null)
             {
                     grdGolfer.SetGridText( event_row, G3_TCM_Caddy_PK, object[0]);
                     grdGolfer.SetGridText( event_row, G3_Caddy_ID, object[1]);
                     grdGolfer.SetGridText( event_row, G3_Caddy_Name, object[2]);
             } 
        }
        else if(event.col == G3_ID && event.row >0)//card no
        {
                var path = System.RootURL + '/form/ja/bk/jabk0034.aspx';
                var object = System.OpenModal( path , 600 , 400 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
                    grdGolfer.SetGridText(grdGolfer.row,G3_ID,object[0])//id
                    grdGolfer.SetGridText(grdGolfer.row,G3_Name,object[2])//name
                    grdGolfer.SetGridText(grdGolfer.row,G3_MOBILE_PHONE,object[3])//phone
                    grdGolfer.SetGridText(grdGolfer.row,G3_GENDER,object[6])//gender
                    grdGolfer.SetGridText(grdGolfer.row,G3_Member_Type,object[1])//member type
                    grdGolfer.SetGridText(grdGolfer.row,G3_Member_PK,object[8])//member pk
	             }
        } 
        else if(event.col == G3_Name && event.row >0)//Player Name
        {
             var path = System.RootURL + '/form/ja/st/jast00070_popup.aspx';
                var object = System.OpenModal( path , 600 , 400 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
                    grdGolfer.SetGridText(grdGolfer.row,G3_Name,object[2])//player name
                    grdGolfer.SetGridText(grdGolfer.row,G3_MOBILE_PHONE,object[6])//phone
                    grdGolfer.SetGridText(grdGolfer.row,G3_GENDER,object[3])//gender
                    //grdGolfer.SetGridText(grdGolfer.row,14,object[0])//booking pk
	             }
        }   
} 
function CheckDataExist(p_oGrid,p_value)
{
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G3_Name) == p_value)
              {
                 return true;
              }
       }
       return false;
}
function OnBKDblClick()
{
   if(grdGolferProfile.row > 0) //if(grdGolferProfile.row > 0 && txtMasterPK.text !="")
    {
       if(grdGolfer.rows-1 < 1)
       {
            grdGolfer.AddRow();
            grdGolfer.SetGridText( grdGolfer.rows-1, G3_TCM_BOOKING_PK, txtMasterPK.text);
            grdGolfer.SetGridText( grdGolfer.rows-1, G3_SEQ, grdGolfer.rows-1 );
           // grdGolfer.SetGridText(grdGolfer.rows-1,G3_Member_Type, 7);
            grdGolfer.SetGridText(grdGolfer.rows-1,G3_Member_Type, 10)

            grdGolfer.SetGridText(grdGolfer.rows-1,G3_Name,grdGolferProfile.GetGridData(event.row,2))//player name
            grdGolfer.SetGridText(grdGolfer.rows-1,G3_MOBILE_PHONE,grdGolferProfile.GetGridData(event.row,6))//phone
            grdGolfer.SetGridText(grdGolfer.rows-1,G3_GENDER,grdGolferProfile.GetGridData(event.row,3))//gender
            grdGolferProfile.SetCellBgColor( event.row, 0 , event.row, grdGolferProfile.cols-2 , 0x00FFFF );
       }
       else
       {
          var col_val = grdGolferProfile.GetGridData(event.row,2);
            if(event.row > 0 && (CheckDataExist(grdGolfer,col_val)))
            {
                alert("Player : "+"'"+grdGolferProfile.GetGridData(event.row,2)+"'"+" already exists.");
            }
            else
            {
                grdGolfer.AddRow();
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_TCM_BOOKING_PK, txtMasterPK.text);
                grdGolfer.SetGridText( grdGolfer.rows-1, G3_SEQ, grdGolfer.rows-1 );
               // grdGolfer.SetGridText(grdGolfer.rows-1,G3_Member_Type, 7);
                grdGolfer.SetGridText(grdGolfer.rows-1,G3_Member_Type, 10)

                grdGolfer.SetGridText(grdGolfer.rows-1,G3_Name,grdGolferProfile.GetGridData(event.row,2))//player name
                grdGolfer.SetGridText(grdGolfer.rows-1,G3_MOBILE_PHONE,grdGolferProfile.GetGridData(event.row,6))//phone
                grdGolfer.SetGridText(grdGolfer.rows-1,G3_GENDER,grdGolferProfile.GetGridData(event.row,3))//gender
                grdGolferProfile.SetCellBgColor( event.row, 0 , event.row, grdGolferProfile.cols-2 , 0x00FFFF );
             }
        }
    }  
}
function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");       
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 function OnToggle2()
 {
    var bottom  = document.all("idBottom");    
    var imgArrow = document.all("imgArrow2");       
    if(imgArrow2.status == "expand")
    {
        bottom.style.display="none";       
        imgArrow.status = "collapse";
        grdGolfer.style.height=250;
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        bottom.style.display="";
        imgArrow.status = "expand";
        grdGolfer.style.height=130;
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//==============================================================================
function OnPrint(){
     if(txtMasterPK.GetData() == '' || txtMasterPK.GetData() == '0'){
        alert("No data for report!");
        return false;
    }
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/rpt_jabk0030_Reservation.rpt&procedure=crm.sp_sel_jabk0030_rpt&parameter=" + txtMasterPK.GetData();
    System.OpenTargetPage(url); 
    window.close();
}
//==============================================================================
function OnDelCaddy()
{
    if (grdGolfer.row>0)
    {
        grdGolfer.SetGridText(grdGolfer.row,G3_TCM_Caddy_PK,'');
        grdGolfer.SetGridText(grdGolfer.row,G3_Caddy_ID,'');
        grdGolfer.SetGridText(grdGolfer.row,G3_Caddy_Name,'');
    }
}
function OnCopy()
{
	if (txtMasterPK.text != '')
	{
		if (confirm("Do you want copy data booking reservation ?"))
		{
			dso_pro_jabk0030_copy.Call();			
		}
	}
	else
	{
		alert("Please,choose player name to copy data.");
	}
}  
function OnHotelConfNo()
{
	var path = System.RootURL + "/form/ja/bk/jabk00030_hotel_confirm_no_popup.aspx?";
			var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
			    txtHotelConfNo.text	= object[7];
			}
}
function OnBookingHotelGolfPrint()
{
	if(txtMasterPK.GetData() == '' || txtMasterPK.GetData() == '0'){
        alert("Please,choose player name to print.");
        return false;
    }
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk00030_booking_hotel_golf.rpt&procedure=CRM.sp_rpt_main_not_use|crm.sp_rpt_jabk0030_hotel|CRM.sp_rpt_jabk0030_lunch_dinner|crm.sp_rpt_jabk0030_golf&parameter=" + txtMasterPK.GetData()+"|"+txtMasterPK.GetData()+"|"+txtMasterPK.GetData()+"|"+txtMasterPK.GetData();
    System.OpenTargetPage(url); 
    //window.close();
}
//==============================================================================
function SetHole()
{
	if(lstGolfType.value==3)
	{
		lstHoles.value=9;
	}
	if(lstGolfType.value==1 || lstGolfType.value==2)
	{
		lstHoles.value=18;
	}
	if(lstGolfType.value==4 || lstGolfType.value==5)
	{
		lstHoles.value=27;
	}
}
function HideShowControl()
{
    if(lstGTDType.value == '')
    {
        document.all("tab_credit").style.display = "none";
        document.all("tab_cash").style.display   = "none";
            
    }
    else if ( lstGTDType.value == '01' )
    {       
        document.all("tab_credit").style.display = "";
        document.all("tab_cash").style.display   = "none";
        
    }
    else if ( lstGTDType.value == '02' )
    {       
        document.all("tab_credit").style.display = "none";
        document.all("tab_cash").style.display   = "none";
    }    
}
</script>

<body>
	<!-------------------------process_copy-date-booking-golf------------------------------------------------>
	<gw:data id="dso_pro_jabk0030_copy" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="process" procedure="crm.sp_pro_jabk0030_copy" > 
			<input>
				 <input bind="txtMasterPK" /> 
			</input> 
			<output> 
				<output bind="txtMasterPK"/>
			</output>
		</dso> 
	</xml> 
</gw:data>
    <!------------------------------------------------------------------>
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
	
    <gw:data id="data_jabk0030_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8" function="crm.sp_sel_jabk0030_5" >
                <inout>
                    <inout bind="txtContactor" /> 
                    <inout bind="lstMemberType" />     
                    <inout bind="txtMemberName" /> 
                    <inout bind="txtTelephone" />
                    <inout bind="txtBusPartnerPK" />
                    <inout bind="txtIDPastport" />
                    <inout bind="txtGender" />  
                    <inout bind="txtAge" />
                    <inout bind="txtMemberPK" />                  
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" function="crm.sp_sel_jabk0030" >
                <input>
                    
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" /> 
                    <input bind="txtMemberSearch" />
                    <input bind="lstStatus1" />
					<input bind="txtCompanyPK_S" />
                </input>
                <output bind="grdBookingList" />
            </dso>
        </xml>
    </gw:data>
    <!----------------------->
        <gw:data id="dsoGolferProfile" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jast00070"> 
                <input> 
                    <input bind="txtPlayerName" />
                </input> 
                <output bind="grdGolferProfile" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30" function="crm.sp_sel_jabk0030_1" procedure="crm.sp_upd_jabk0030_1">
                <inout>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="txtContactor" /> 
                    <inout bind="lstMemberType" />     
                    <inout bind="txtMemberName" /> 
                    <inout bind="txtTelephone" />                                        
                    <inout bind="txtNumberGuest" />
                    <inout bind="txtGroupNumber" />
                    <inout bind="chkSlipt" />                    
                    <inout bind="checkShortGun" />                    
                    <inout bind="dtBookDate" />
                    <inout bind="txtTime" />
                    <inout bind="txtCreateDate" />
                    <inout bind="lstGolfType" />                    
                    <inout bind="lstHoles" />                                                          
                    <inout bind="txtRemark" />
                    <inout bind="txtBusPartnerPK" />
                    <inout bind="txtEventName" />
                    <inout bind="lstStatus" /> 
                    <inout bind="txtBookingNo" /> 
                    <inout bind="txtEmail" />
					<inout bind="txtTotalGuest" /> 
					<inout bind="txtHotelConfNo" />  					
					<inout bind="lstGTDType"/>	
					<inout bind="txtCreditNo"/>	
					<inout bind="txtExpDate"/>	
					<inout bind="txtCCV"/>	
					<inout bind="lstCreditType"/>	 
					<inout bind="txtCreditOwner"/>
					<inout bind="lstNation"/>		
					<inout bind="lblModifiedBy"/>
					<inout bind="lblModifiedDate"/>
					<inout bind="txtCreateBy" /> 
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jabk0030_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" function="crm.sp_sel_jabk0030_2" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" procedure="crm.sp_upd_jabk0030_2" > 
                <input> 
                    <inout bind="txtMasterPK" />    
					<inout bind="txtGuestName" /> 
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <!------------------------------------------------------------------>
    <table style="width: 100%; vertical-align: top;" border="1">
        <tr valign="top">
            <td style="width: 30%" id="idLEFT">
                <table style="width: 100%;">
                    <tr valign="top">
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 10%" align="right">
                                        Date</td>
                                    <td style="width: 65%; white-space: nowrap">
                                        <gw:datebox id="dtFromDate" lang="1" onchange="OnSearch('BookingList')" />
                                        ~<gw:datebox id="dtToDate" lang="1" onchange="OnSearch('BookingList')" />
                                    </td>
                                    <td style="width: 20%">
                                        <gw:imgbtn id="btnSearch2" img="search" onclick="OnSearch('BookingList')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 7%">
                                        Status</td>
                                    <td style="width: 50%; white-space: nowrap">
                                        <gw:list id="lstStatus1" styles="width:100%" onchange="OnSearch('BookingList')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 7%">
                                        <a href="#" onclick="OnCheckCustomer('1')">Company</a></td>
                                    <td style="width: 90%; white-space: nowrap">
                                        <gw:textbox id="txtCompanyNameS" styles="width:100%" readonly="true" />
                                    </td>
									<td style="width: 3%"><gw:imgbtn id="btnClearCompanyS" img="reset" alt="Reset" onclick="txtCompanyNameS.text='';txtCompanyPK_S.text='';" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 10%" align="right">
                                        Customer</td>
                                    <td style="width: 60%; white-space: nowrap">
                                        <gw:textbox id="txtMemberSearch" styles="width:100%" onenterkey="OnSearch('BookingList')" />
                                    </td>
                                    <td style="width: 30%; white-space: nowrap">
                                        Rows:<gw:label id="lblRows" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <gw:grid id='grdBookingList' header='_pk|Member Type|Player Name|Time|Contact Person|Book Date|Reservation#'
                                            format='0|0|0|0|0|0' 
                                            sorting='T' styles='width:100%; height:447' oncellclick="OnSearch('2')" autosize='T' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%" id="idRIGHT">
                <table style="width: 100%; vertical-align: top" border="0" cellpadding="0" cellspacing="0">
                    <tr valign="top">
                        <td>
                            <table style="width: 100%; vertical-align: top">
                                <tr valign="top">
                                    <td style="width:10%">
                                        <b style="color: Red">*</b>Play Date
                                    </td>
                                    <td style="width:15%" align="left">
                                        <gw:datebox id="dtBookDate" lang="1" nullaccept="true" onchange="txtTime.text=''" />
                                    </td>
                                    <td style="width: 15%" align="left">
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('time')"><b style="color: Red">
                                            *</b>Teeup Time</b>
                                    </td>
                                    <td style="width:15%">
										<gw:textbox id="txtTime" styles="width:100%" />  
                                    </td>
                                    <td style="width:10%">
                                        Status
                                    </td>
                                    <td style="width:20%">
                                        <gw:list id="lstStatus" styles="width:100%" onchange="" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnSearch1" img="search" alt="Search" text="Search" onclick="OnSearch('Booking')" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnNew1" alt="Add New" img="New" text="Add" onclick="OnAddNew('Booking')" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnDelete1" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Booking')" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnUnDelete1" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete('Booking')" />
                                    </td>
				    <td style="width:3%">
                                        <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" />
                                    </td>
                                    <td style="width:3%">
                                        <gw:imgbtn id="btnSave1" img="save" alt="Save" text="Save" onclick="OnSave('Booking')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table style="width: 100%; vertical-align: top">
                                <tr style="width: 100%" valign="top">
                                    <td style="width:10%">
                                        <b style="color: Red">*</b>Course
                                    </td>
                                    <td style="width:20%">
                                        <gw:list id="lstGolfType" styles="color:blue;width:100%" onchange="SetHole()" />
                                    </td>
                                    <td style="width: 15%" align="left">
                                        Booking No
                                    </td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtBookingNo" styles="width:100%" readonly="true" csstype="mandatory"
                                            onenterkey="" />
                                    </td>
									<td style="width: 10%" align="left">
                                       </td>
                                    <td style="width: 5%" align="left">
                                        <b style="color: Red">*</b>Holes</td>
                                    <td style="width: 20%">
                                        <gw:list id="lstHoles" styles="color:blue;width:100%" onchange="OnHoleChange()" />
                                    </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table style="width: 100%; vertical-align: top">
                                <tr style="width: 100%" valign="top">
                                    <td style="width: 10%; white-space: nowrap">
                                        <a href="#" onclick="OnCheckCustomer('2')">Company</a>
                                    </td>
                                    <td style="width: 20%">
                                        <gw:textbox id="txtMemberName" styles="width:100%" readonly="true" />
                                    </td>
                                    <td style="width: 15%">
                                        <b style="color: Red">*</b>Contact
                                    </td>
                                    <td style="width: 19%">
                                        <gw:textbox id="txtContactor" styles="width:100%" />
                                    </td>
                                    <td style="width: 16%; white-space: nowrap">
                                        Telephone
                                    </td>
                                    <td align="left" style="width:20%">
                                        <gw:textbox id="txtTelephone" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table style="width: 100%; vertical-align: top">
                                <tr style="width: 100%" valign="top">
                                    <td style="width: 10%">
                                        Crt.Date</td>
                                    <td style="width:20%">
                                        <gw:textbox id="txtCreateDate" styles="width:100%" readonly="true" />
                                    </td>
                                    <td style="width: 15%" align="left">
                                        Crt.By
                                    </td>
                                    <td align="left" style="width:19%">
                                        <gw:textbox id="txtCreateBy" styles="width:100%" />
                                    </td>
									<td style="width: 16%" align="left">
                                        Total Guest
                                    </td>
                                    <td align="left" style="width:20%">
                                        <gw:textbox id="txtTotalGuest" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table style="width: 100%; vertical-align: top">
                                <tr style="width: 100%" align="left" valign="top">
									<td style="width: 10%">
                                        <a href="#" onclick="OnHotelConfNo()">Hotel.Conf#</a></td>
                                    <td style="width:18%">
                                        <gw:textbox id="txtHotelConfNo" styles="width:100%" readonly="true" />
                                    </td>
									<td style="width: 2%"><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtHotelConfNo.text='';" /></td>
                                    <td style="width: 11%" align="left">
                                        Event
                                    </td>
                                    <td style="width: 19%" align="left">
                                        <gw:textbox id="txtEventName" styles="width:100%;" />
                                    </td>
                                    <td style="width: 16%; white-space: nowrap" align="center">
                                        Email 
                                    </td>
                                    <td style="width: 20%; white-space: nowrap" align="left">
                                        <gw:textbox id="txtEmail" styles="width:100%;" />
                                    </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table style="width: 100%; vertical-align: top">
                                <tr style="width: 100%" align="left" valign="top">
                                    <td style="width: 10%" align="left">
                                        Description
                                    </td>
                                    <td align="left" style="width: 54%">
                                        <gw:textbox id="txtRemark" styles="width:100%" />
                                    </td>
									<td style="width: 9%; white-space: nowrap" align="center">
                                        Shot Gun <gw:checkbox id="checkShortGun" defaultvalue="Y|N" value="N" tyles="width:35%" />
                                    </td>
									<td style="width: 7%;" align="right" >Nation</td>
                                    <td style="width:20%; white-space: nowrap" align="left">  
									<gw:list id="lstNation" styles="color:blue;width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr>
                        <td >
                            <table style="width: 100%; height: 100%; background-color: #BDE9FF">
                                <tr>
                                    <td style="width: 5%; white-space: nowrap">
                                        GTD Type
                                    </td>
                                    <td style="width: 45%">
                                        <gw:list id="lstGTDType" text="" styles='width:100%' onchange="HideShowControl()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        Modified by:
                                    </td>
                                    <td style="width: 10%" align="right"> 
                                        <gw:label id="lblModifiedBy" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        date:
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <gw:label id="lblModifiedDate" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 50%" colspan="4">
                                        <fieldset style="padding: 5">
                                            <table style="width: 100%; height: 100%" id="tab_credit">
                                                <tr>
                                                    <td style="width: 5%; white-space: nowrap" align="right">
                                                        Credit Type
                                                    </td>
                                                    <td style="width: 20%">
                                                        <gw:list id="lstCreditType" text="" styles='width:100%' />
                                                    </td>
                                                    <td style="width: 5%; white-space: nowrap">
                                                        Exp.Date
                                                    </td>
                                                    <td style="width: 20%">
                                                        <gw:textbox id="txtExpDate" styles="text-align:left;width:120;" />
                                                    </td>
                                                    <td style="width: 5%; white-space: nowrap" align="right">
                                                        Credit CCV
                                                    </td>
                                                    <td style="width: 20%">
                                                        <gw:textbox id="txtCCV" styles="text-align:left;width:120;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 5%">
                                                        Card No
                                                    </td>
                                                    <td style="width: 20%">
                                                        <gw:textbox id="txtCreditNo" styles="text-align:left;width:100%;" onenterkey="OnEnterEvent(this)" />
                                                    </td>
                                                    <td style="width: 5%; white-space: nowrap" align="right">
                                                        Credit Owner
                                                    </td>
                                                    <td style="width: 20%">
                                                        <gw:textbox id="txtCreditOwner" styles="width: 100%" />
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 50%" colspan="4">
                                        <fieldset style="padding: 5">
                                            <table style="width: 100%; height: 100%" id="tab_cash">
                                                <tr>
                                                    <td style="width: 5%">
                                                        Cash
                                                    </td>
                                                    <td style="width: 25%">
                                                        <gw:textbox id="txtCash" styles="width: 100%" type="number" format="###,###,###,###"
                                                            styles="text-align:right;width:100%;color:red" />
                                                    </td>
                                                    <td style="width: 5%">
                                                    </td>
                                                    <td style="width: 65%">
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table width="100%">
                                <tr>
                                    <td style="width:15%" align="left">
                                        Total Player:
                                    </td>
                                    <td style="width:5%">
										<gw:label id="lblTotalRow" />
                                    </td>
									<td style="width:15%" align="left"> Guest name:</td>
									<td style="width:15%" align="left">
										 <gw:textbox id="txtGuestName" onenterkey="data_jabk0030_2.Call('SELECT');" />
									</td>
									<td style="width:36%" align="right">
										<gw:imgbtn id="ibtnReport" img="printer" alt="Golf&Hotel Report" onclick="OnBookingHotelGolfPrint()" />
									</td>
                                    <td style="width:5%" align="right">
										<gw:icon id="idBtnCopy" img="2" text="Copy" styles='width:100%' onclick="OnCopy()" />
                                    </td>
                                    <td style="width:3%">
										<gw:icon id="idBtnDelCaddy" img="2" text="Del Caddy" styles='width:100%' onclick="OnDelCaddy()" />
                                    </td>
                                    <td style="width:3%">
                                        <gw:imgbtn id="btnNew4" alt="Add New" img="New" text="Add" onclick="OnAddNew('grdGolfer')" />
                                    </td>
                                    <td style="width:3%">
                                        <gw:imgbtn id="btnDelete4" img="delete" alt="Delete" text="Delete" onclick="OnDelete('grdGolfer')" />
                                    </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td style="width: 100%">
                            <gw:grid id='grdGolfer' header='_PK|No|Group|Member#|*Member Type|*Player Name|Gender|Mobile Phone|Start Hole|_TCM_Caddy_pk|Caddy#.|Caddy Name|Book Cart|Book Golfbag|Book Shoes|Remark|_TCM_BOOKING_PK|_Member_pk|HDCP'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|3|3|3|0|0|0|0' 
                                aligns='0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                defaults='||||||||||||||||||' 
                                editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' 
                                widths='1000|1000|2500|2200|1400|1000|1000|1000|1000|1000|1000|1000|300|700|700|700|1000|1000|1000'
                                sorting='T' 
                                styles='width:100%; height:310' 
                                onafteredit="CheckInput('grdGolfer')"
                                autosize='T' 
                                oncelldblclick='OnGridCellDblClick()' />
                        </td>
                    </tr>
                    <tr id="idBottom" style="display:none">
						<td >
							<table width="100%">
								<tr valign="top">
									<td style="width: 100%">
										<table style="width: 100%; vertical-align: top">
											<tr valign="top">
												<td style="width: 10%" align="left">
													Name</td>
												<td style="width: 58%">
													<gw:textbox id="txtPlayerName" styles='width:100%;' onenterkey="dsoGolferProfile.Call('SELECT');" />
												</td>
												<td style="width:28%">
												</td>
												<td style="width: 1%">
													<gw:imgbtn id="btnNew2" alt="Add New" img="New" text="Add" onclick="OnSearch('Item')" styles='width:100%; display:none' />
												</td>
												
											</tr>
										</table>
									</td>
								</tr>
								<tr valign="top">
									<td  style="width: 100%" id="grdProfile">
										<gw:grid id='grdGolferProfile' header="_PK|No|Golfer Name| Gender|Birthday|Nationality| Mobile Phone| Telephone| Home  Address| Company Name|Company Address| Company Phone|Hobby| Description| Tax Code"
											format="0|0|0|0|4|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
											check="||0|0||0|||||||||" defaults="||||||||||||||" editcol="0|0|1|1|1|1|1|1|1|1|1|1|1"
											widths="0|1000|1500|2000|1200|30000|1500|2000|1200|3000|100|1000" sorting='T'
											acceptnulldate="T" autosize='T' styles="width:100%; height:110" oncelldblclick="OnBKDblClick()" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				   
                </table>
            </td>
        </tr>
    </table>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
	<img status="expand" id="imgArrow2" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left:300; top: 500;display:none;" onclick="OnToggle2()" />	
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:textbox id="txtBusPartnerPK" styles="width:100%; display:none" />
    <gw:textbox id="txtIDPastport" styles="width:100%; display:none" />
    <gw:textbox id="txtGender" styles="width:100%; display:none" />
    <gw:textbox id="txtAge" styles="width:100%; display:none" />
    <gw:textbox id="txtMemberPK" styles="width:100%; display:none" />
    <gw:datebox id="dtDateToday" lang="1" style="width: 100%; display: none" />
    <gw:textbox id="CONFIRM_YN" text='N' styles="display: none" />
    <gw:list id="lstMemberType" styles="display: none" />
    <gw:textbox id="txtNumberGuest" styles="width:100%;display: none" />
    <gw:checkbox id="chkSlipt" defaultvalue="Y|N" value="Y" style="display: none" />
    <gw:list id="lstDateBooking" style="display: none" />
	<gw:textbox id="txtTmpMemberID" text="" styles="display:none" />
    <gw:grid id='grdMemberList' header='MemberID|Name|Member Type'
     format='0|0|0'  styles='display:none' />
	 
	 <gw:textbox id="txtCompanyPK_S" styles="width:100%; display:none" />
	 <gw:textbox id="txtGroupNumber" styles="width:100%;display: none" />
    <!--------------------------------------------------------------------------->
</body>
</html>
