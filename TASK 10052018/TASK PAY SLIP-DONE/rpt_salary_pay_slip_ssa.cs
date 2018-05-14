using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_salary_pay_slip_ssa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        //create template file
        string TemplateFile = "rpt_salary_pay_slip_ssa.xlsx"; //mẫu xlsx
        string TempFile = "../../../system/temp/rpt_salary_pay_slip_ssa" + DateTime.Now.ToString("hhmmss") + Session["User_ID"].ToString() + ".xls";  //export file xls
        
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        //phạm vi
        IRange range;
        IPageBreaks pbs = exSheet.HPageBreaks;
        IRange usedrange = exSheet.UsedRange;
        //pbs.Reset();

        string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_times, p_emp_type, p_from_leftdate, p_to_leftdate;

        p_dept = Request["l_dept"].ToString();
        p_group = Request["l_group"].ToString();
        p_status = Request["l_status"].ToString();
        p_type = Request["l_type"].ToString();
        p_pay_type = Request["l_pay_type"].ToString();
        p_emp_id = Request["l_emp_id"].ToString();
        p_work_mon = Request["l_work_mon"].ToString();
        p_times = Request["l_Times_r"].ToString();
        p_emp_type = Request["l_Emp_Type"].ToString();
        p_from_leftdate = Request["l_from_leftdate"].ToString();
        p_to_leftdate = Request["l_to_leftdate"].ToString();
        string p_m_type = Request.QueryString["l_m_type"].ToString();     
    
        int irow; //dòng  
        int loop_height = 48;
        int loop_width = 9;

        string SQL
         = "select to_char(to_date(A.WORK_MON,'yyyymm'),'MM-YYYY') c0 " +
             "    , A.FULL_NAME c1, A.EMP_ID c2 " +
             "    ,A.DEPT_NM c3 " +
             "    ,to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c4 " +
             "    ,case when nvl(a.CONFIRM_DT,a.FROM_DT) between a.FROM_DT and a.TO_DT then  round(nvl(a.SAL_WITH_WT_L2,0),5) " +
       "                when nvl(a.CONFIRM_DT,a.FROM_DT) > a.TO_DT then  round(nvl(a.SAL_WITH_WT_L1,0),5) " +
       "                else round(nvl(a.SAL_WITH_WT_L2,0),5) " +
       "         end c5 " +
             "    ,nvl(S.ALLOW_AMT2,0) c6 " +
             "    ,nvl(S.ALLOW_AMT1,0) c7 " +
             "    ,400000 c8 " +
             "    ,100000 c9 " +
             "    ,round(nvl(A.WT_L1,0)/8+nvl(A.WT_L2,0)/8+nvl(A.HOL_DAY_L1,0)+nvl(A.HOL_DAY_L2,0),5) c10 " +
             "    ,round(nvl(A.TOTAL_ABS_PAY_L1,0)/8+nvl(A.TOTAL_ABS_PAY_L2,0)/8,5) c11 " +
             "    ,round(nvl(A.WT_L1,0)/8+nvl(A.WT_L2,0)/8+nvl(A.HOL_DAY_L1,0)+nvl(A.HOL_DAY_L2,0) " +
             "        + nvl(A.TOTAL_ABS_PAY_L1,0)/8+nvl(A.TOTAL_ABS_PAY_L2,0)/8,5) c12 " +
             "    ,round(nvl(A.TOTAL_ABS_NPAY_L1,0)/8+nvl(A.TOTAL_ABS_NPAY_L2,0)/8,5) c13 " +
             "    ,nvl((round(nvl(A.OT_L1,0)+nvl( A.OT_L2,0),5)),0) c14 " +
             "    ,nvl((round(nvl(A.NOT_185_L1,0)+nvl( A.NOT_185_L2,0),5)),0) c15 " +
             "    ,nvl((round(nvl(A.NOT_195_L1,0)+nvl( A.NOT_195_L2,0),5)),0) c16 " +             
             "    ,round(nvl(A.ST_L1,0)+nvl( A.ST_L2,0)+nvl(A.OST_L1,0)+nvl( A.OST_L2,0)+nvl(A.NOST_L1,0)+nvl( A.NOST_L2,0),5) c17 " +
             "    ,round(nvl(A.NST_L1,0)+nvl( A.NST_L2,0),5) c18 " +
             "    ,round(nvl(A.HT_L1,0)+nvl( A.HT_L2,0),5) c19 " +
             "    ,round(nvl(A.NHT_L1,0)+nvl( A.NHT_L2,0),5) c20 " +
             "    ,round(nvl(A.OHT_L1,0)+nvl( A.OHT_L2,0) + nvl(A.NOHT_L1,0)+nvl( A.NOHT_L2,0) +nvl(A.ST_300_L1,0)+nvl( A.ST_300_L2,0)+nvl(A.OST_300_L1,0)+nvl( A.OST_300_L2,0),5) c21 " +
             "    ,nvl((round(nvl(A.OT_L1,0)+nvl( A.OT_L2,0) " +
             "    +nvl(A.NOT_185_L1,0)+nvl( A.NOT_185_L2,0) " +
             "    +nvl(A.NOT_195_L1,0)+nvl( A.NOT_195_L2,0) " +
             "    +nvl(A.NOT_195_2_L1,0)+nvl( A.NOT_195_2_L2,0) " +
             "    +nvl(A.ST_L1,0)+nvl( A.ST_L2,0)+nvl(A.OST_L1,0)+nvl( A.OST_L2,0) " +
             "    +nvl(A.NST_L1,0)+nvl( A.NST_L2,0)+nvl(A.NOST_L1,0)+nvl( A.NOST_L2,0) " +
             "    +nvl(A.HT_L1,0)+nvl( A.HT_L2,0) " +
             "    +nvl(A.NHT_L1,0)+nvl( A.NHT_L2,0) " +
             "	  +nvl(A.ST_300_L1,0)+nvl( A.ST_300_L2,0)+nvl(A.OST_300_L1,0)+nvl( A.OST_300_L2,0)	" +
             "    +nvl(A.OHT_L1,0)+nvl( A.OHT_L2,0) + nvl(A.NOHT_L1,0)+nvl( A.NOHT_L2,0),5)),0) c22 " +
             "    ,round(nvl(A.Total_wt_hol_abs_l1_amt,0)+nvl(A.Total_wt_hol_abs_l2_amt,0) " +
             "            ,5) c23 " +
             "    ,round(nvl(A.TOTAL_OT_L1_AMT,0)+nvl(A.TOTAL_OT_L2_AMT,0) " +
             "            -nvl(A.NT_30_L1_AMT,0)-nvl(A.NT_30_L2_AMT,0),5) c24 " +
             "    ,round(nvl(A.NT_30_L1_AMT,0)+nvl(A.NT_30_L2_AMT,0),5) c25 " +
             "    ,round(nvl(A.ALLOW_K4_AMT,0),5) c26 " +
             "    ,round(nvl(A.ALLOW_AMT2,0),5) c27 " +
             "    ,round(nvl(A.ALLOW_AMT1,0),5) c28 " +
             "    ,round(nvl(A.ALLOW_K1_AMT,0),5) c29 " +
             "    ,round(nvl(A.ALLOW_K2_AMT,0),5) c30                                     " +
             "    ,round(nvl(A.ALLOW_K5_AMT,0),5) c31 " +
             "    ,round(nvl(A.ALLOW_K3_AMT,0),5) c32 " +
             "    ,round(nvl(A.RETURN_AMT,0)+nvl(A.RETURN_NO_PIT,0)-nvl(a.refund_business_trip_amt,0) ,5) c33 " +
             "    ,round(nvl(a.refund_business_trip_amt,0),0) c34 " +
             "    ,round(nvl(A.GROSS_AMT,0),5) c35 " +
             "    ,round(nvl(A.OT_TAX_L1_AMT,0)+nvl(A.OT_TAX_L2_AMT,0),5) c36 " +
             "    ,round(nvl(A.DEDUCT_PIT,0),5) c37 " +
             "    ,round(nvl(A.INCOME_BEFORE_TAX,0),5) c38 " +
             "    ,round(nvl(A.SOCIAL_AMT,0),5) c39 " +
             "    ,round(nvl(A.HEALTH_AMT,0),5) c40 " +
             "    ,round(nvl(A.UNEMP_INS,0),5) c41 " +
             "    ,round(nvl(A.HEALTH_CARD_AMT ,0),5) c42 " +
             "    ,round(nvl(A.UNION_AMT,0),5) c43 " +
             "    ,round(nvl(A.INCOME_TAX,0),5) c44 " +
             "    ,0 c45 " +
             "    ,round(nvl(A.ADVANCE_AMT,0)+nvl( A.ADVANCE_NO_PIT,0) ,5) c46  " +
             "    ,round(nvl(A.SOCIAL_AMT,0) " +
             "    +nvl(A.HEALTH_AMT,0) " +
             "    +nvl(A.UNEMP_INS,0) " +
             "    +nvl(A.HEALTH_CARD_AMT ,0) " +
             "    +nvl(A.UNION_AMT,0) " +
             "    +nvl(A.INCOME_TAX,0)     " +
             "    +nvl(A.ADVANCE_AMT,0)+nvl( A.ADVANCE_NO_PIT,0) - nvl(a.deduct_health_card,0) ,5) c47 " +
             "    ,round(nvl(A.NET_AMT,0) ,5) c48 " +
             "    ,to_char(add_months(to_date(A.WORK_MON||'20','yyyymmdd'),1),'dd/mm/yyyy') c49 " +
             "    ,round(nvl(a.sickness_amt,0),5) c50  " +
             "    ,round(nvl(late.in_late,0) + nvl(late.out_early,0) ,5) c51  " +
             "    ,nvl(a.seq,0) c52  " +
             "        ,round(nvl(a.ALE_STOP_AMT,0)  ,5) ANNUAL_STOP_AMT " +
            "        ,round( nvl(a.WT_L1,0)/8+nvl(a.WT_L2,0)/8+nvl(a.HOL_DAY_L1,0)+nvl(a.HOL_DAY_L2,0) - (NVL(a.wd_nt_l1,0)+NVL(a.wd_nt_l2,0))/8,5) work_day  " +
            "        ,round((NVL(a.wd_nt_l1,0)+NVL(a.wd_nt_l2,0))/8,5) work_day_nt  " +
            "        ,round( nvl(s.ALLOW_AMT3,0) ,5) ALLOW_AMT3_FULL  " +

           "        ,round( nvl(s.ALLOW_AMT4,0) ,5) ALLOW_AMT4_FULL  " +
           "        ,round( nvl(a.ALLOW_AMT3,0) ,5) ALLOW_AMT3  " +

           "        ,round( nvl(a.ALLOW_AMT4,0) ,5) ALLOW_AMT4  " +
           "        ,round( nvl(a.children_allow_amt ,0) ,5) children_allow_amt  " +
           "    , nvl((round(nvl(NOT_195_2_L1,0) + nvl(NOT_195_2_L2,0),0)),0) NOT_195_2 " +        
          // ",99 as NOT_195_2 " +
           "    , round(nvl(NOT_195_2_L1_AMT,0) + nvl(NOT_195_2_L2_AMT,0),0) NOT_195_2_AMT  " +
           "	,round( nvl(a.senior_amt,0),0) senior_amt	" +
           "        ,round( nvl(s.ALLOW_AMT5,0) ,5) ALLOW_AMT5_FULL  " +
           "        ,round( nvl(a.ALLOW_AMT5,0) ,5) ALLOW_AMT5 , a.DEPT_NM " +
           "        ,round( nvl(a.ALLOW_AMT6,0) ,5) ALLOW_AMT6  " +
           "        ,round( nvl(s.ALLOW_AMT6,0) ,5) ALLOW_AMT6_FULL  " +
           "    ,(ROUND (NVL (A.SOCIAL_AMT, 0), 5)+ROUND (NVL (A.HEALTH_AMT, 0), 5)+ROUND (NVL (A.UNEMP_INS, 0), 5)) BHXH_FULL "+
            "from thr_month_salary a,comm.tco_org b,comm.tco_company c,thr_salary_manage s, thr_month_summary late " +
            " where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
            " and b.del_if=0 and a.tco_dept_pk=b.pk  " +
            " and a.thr_emp_pk=late.thr_emp_pk(+) " +
            " and a.work_mon = late.work_mon(+) " +
            " and late.del_if = 0 " +
            " and S.DEL_IF(+)=0 and S.THR_EMP_PK(+)=A.THR_EMP_PK and S.WORK_MON(+)=A.WORK_MON " +
            " and c.del_if(+)=0 and b.tco_company_pk(+)=c.pk " +
            " and (a.tco_dept_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM comm.tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_dept + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_dept + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_dept + "' = 'ALL') " +
            " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
            " and a.emp_id like '%" + p_emp_id + "%' " +
            " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
            " and ('" + p_from_leftdate + "' is null or '" + p_to_leftdate + "' is null or a.left_dt between '" + p_from_leftdate + "' and '" + p_to_leftdate + "')" +
            " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
            " and decode('" + p_emp_type + "','ALL','ALL',a.Employee_Type)='" + p_emp_type + "'" +
            " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
            " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
            " and nvl(a.net_amt,0) " + p_type +
           //" and A.EMP_ID in (012414,012998,013210,011928,010515,013264,09500,010070,012269,011811    )" +
            " order by nvl(b.seq,0),a .DEPT_NM , a.EMP_ID";
            
            

       // Response.Write(SQL);
       // Response.End();
		
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        irow = dt_emp.Rows.Count; //đếm tổng số dòng     
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
        for (int i = 1; i < (irow + 1) / 2; i++)
        {
            //exSheet.Range[1, 1, loop_height, loop_width].Copy(exSheet.Range[i, loop_width, (i + 1) * loop_height, loop_width * 2], XlPasteType.xlPasteAll);
            exSheet.Range[1, 1, loop_height, loop_width].Copy(exSheet.Range[(i) * loop_height, 1, (i + 1) * loop_height, loop_width], XlPasteType.xlPasteAll);
            pbs.Add(usedrange.Rows[(loop_height*2) * (i)]); //code phân trang 
        }   
   
       // exSheet.Cells["K1"].Value = "TEST " + dt_emp.Rows.Count;

        for (int i = 0; i < irow ; i++)
        {
            if (i % 2 == 0)
            {
                //exSheet.Cells["A" + (3 + (loop_height * (i / 2)))].Value = "Thông tin";
                //exSheet.Cells["A" + (5 + (loop_height * (i / 2)))].Value = "Công";
                //exSheet.Cells["A" + (9 + (loop_height * (i / 2)))].Value = "Tăng ca";
                //exSheet.Cells["A" + (16 + (loop_height * (i / 2)))].Value = "Công";
                //exSheet.Cells["A" + (26 + (loop_height * (i / 2)))].Value = "Tăng ca";
                //exSheet.Cells["A" + (29 + (loop_height * (i / 2)))].Value = "Khác";
                //exSheet.Cells["A" + (38 + (loop_height * (i / 2)))].Value = "Khấu trừ";


                exSheet.Cells["A" + (1 + (loop_height * (i / 2)))].Value = "CÔNG TY TNHH SUNG SHIN A VIỆT NAM";
                exSheet.Cells["D" + (1 + (loop_height * (i / 2)))].Value = "No: " + (i + 1);
                exSheet.Cells["A" + (2 + (loop_height * (i / 2)))].Value = "PHIẾU LƯƠNG THÁNG " + dt_emp.Rows[i]["C0"].ToString();
                //Thông tin
                exSheet.Cells["B" + (3 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C1"].ToString();//tên
                exSheet.Cells["C" + (3 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C2"].ToString();//mã nv
                exSheet.Cells["B" + (4 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C3"].ToString();//tên phòng ban
                exSheet.Cells["C" + (4 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C4"].ToString(); //need check
                //Công
                exSheet.Cells["B" + (5 + (loop_height * (i / 2)))].Value = "Tổng công ngày";
                exSheet.Cells["D" + (5 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["work_day"].ToString()); //tổng công ngày
                exSheet.Cells["B" + (6 + (loop_height * (i / 2)))].Value = "Tổng công đêm";
                exSheet.Cells["D" + (6 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["work_day_nt"].ToString()); // tổng công đêm
                exSheet.Cells["B" + (7 + (loop_height * (i / 2)))].Value = "Số ngày nghỉ hưởng lương";
                exSheet.Cells["D" + (7 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C11"].ToString()); //số ngày nghỉ hưởng lương
                exSheet.Cells["B" + (8 + (loop_height * (i / 2)))].Value = "TỔNG NGÀY HƯỞNG LƯƠNG";
                exSheet.Cells["D" + (8 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C12"].ToString()); //TỔNG NGÀY HƯỞNG LƯƠNG
                //Tăng ca
                exSheet.Cells["B" + (9 + (loop_height * (i / 2)))].Value = "Danh mục";
                exSheet.Cells["C" + (9 + (loop_height * (i / 2)))].Value = "Ngày";
                exSheet.Cells["D" + (9 + (loop_height * (i / 2)))].Value = "Đêm";
                exSheet.Cells["B" + (10 + (loop_height * (i / 2)))].Value = "Ngày thường";
                exSheet.Cells["C" + (10 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C14"].ToString()); //Ngày thường ca ngày x150%
                exSheet.Cells["D" + (10 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C15"].ToString()); //Ngày thường ca đêm x185%

                exSheet.Cells["B" + (11 + (loop_height * (i / 2)))].Value = "Sau 22 giờ";                
                exSheet.Cells["C" + (11 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C16"].ToString());    //ca ngày sau 22h x200%
                exSheet.Cells["D" + (11 + (loop_height * (i / 2)))].Value =  Double.Parse(dt_emp.Rows[i]["NOT_195_2"].ToString()); //ca ngày sau 22h x210%
                exSheet.Cells["B" + (12 + (loop_height * (i / 2)))].Value = "Chủ nhật";
                exSheet.Cells["C" + (12 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C17"].ToString()); //Chủ nhật x200%
                exSheet.Cells["D" + (12 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C18"].ToString()); //Chủ nhật x270%
                exSheet.Cells["B" + (13 + (loop_height * (i / 2)))].Value = "Lễ - Tết";
                exSheet.Cells["C" + (13 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C19"].ToString()); //Lễ - Tết x300%
                exSheet.Cells["D" + (13 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C20"].ToString()); //Lễ - Tết x390%
                exSheet.Cells["B" + (14 + (loop_height * (i / 2)))].Value = "Tổng tăng ca";
                double total_ngay = Double.Parse(dt_emp.Rows[i]["C14"].ToString()) + Double.Parse(dt_emp.Rows[i]["C16"].ToString()) + Double.Parse(dt_emp.Rows[i]["C17"].ToString()) + Double.Parse(dt_emp.Rows[i]["C19"].ToString());
                double total_dem = Double.Parse(dt_emp.Rows[i]["C15"].ToString()) + Double.Parse(dt_emp.Rows[i]["NOT_195_2"].ToString()) + Double.Parse(dt_emp.Rows[i]["C18"].ToString()) + Double.Parse(dt_emp.Rows[i]["C20"].ToString());
                //exSheet.Cells["C" + (14 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C22"].ToString()); //Tổng tăng ca
                exSheet.Cells["C" + (14 + (loop_height * (i / 2)))].Value = total_ngay; //Tổng tăng ca ngày
                exSheet.Cells["D" + (14 + (loop_height * (i / 2)))].Value = total_dem; //Tổng tăng ca đêm
                //Tính lương
                exSheet.Cells["A" + (15 + (loop_height * (i / 2)))].Value = "Tính lương";
                exSheet.Cells["C" + (15 + (loop_height * (i / 2)))].Value = "Đủ tháng";
                exSheet.Cells["D" + (15 + (loop_height * (i / 2)))].Value = "Tháng " + dt_emp.Rows[i]["C0"].ToString().Substring(1, 1);

                exSheet.Cells["B" + (16 + (loop_height * (i / 2)))].Value = "Lương cơ bản";
                exSheet.Cells["C" + (16 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C5"].ToString())); //lương cơ bản full
                exSheet.Cells["D" + (16 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C23"].ToString())); //lương cơ bản thực tế

                exSheet.Cells["B" + (17 + (loop_height * (i / 2)))].Value = "Phụ cấp chức vụ";
                exSheet.Cells["C" + (17 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["ALLOW_AMT5_FULL"].ToString())); //phụ cấp chức vụ
                exSheet.Cells["D" + (17 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["ALLOW_AMT5"].ToString())); //phụ cấp chức vụ

                exSheet.Cells["B" + (18 + (loop_height * (i / 2)))].Value = "Phụ cấp trách nhiệm";
                exSheet.Cells["C" + (18 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C7"].ToString()); //phụ cấp trách nhiệm
                exSheet.Cells["D" + (18 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C28"].ToString()); //phụ cấp trách nhiệm

                exSheet.Cells["B" + (19 + (loop_height * (i / 2)))].Value = "Phụ cấp thâm niên";
                exSheet.Cells["C" + (19 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["SENIOR_AMT"].ToString()); //phụ cấp thâm niên
                exSheet.Cells["D" + (19 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C32"].ToString()); //phụ cấp thâm niên

                exSheet.Cells["B" + (20 + (loop_height * (i / 2)))].Value = "Trợ cấp công việc";
                exSheet.Cells["C" + (20 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C6"].ToString()); //trợ cấp công việc
                exSheet.Cells["D" + (20 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C27"].ToString()); //trợ cấp công việc

                exSheet.Cells["B" + (21 + (loop_height * (i / 2)))].Value = "Trợ cấp ưu đãi";
                exSheet.Cells["C" + (21 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT3"].ToString()); //trợ cấp ưu đãi
                exSheet.Cells["D" + (21 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT3"].ToString()); //trợ cấp ưu đãi

                exSheet.Cells["B" + (22 + (loop_height * (i / 2)))].Value = "Trợ cấp sinh hoạt";
                exSheet.Cells["C" + (22 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C8"].ToString()); //trợ cấp sinh hoạt
                exSheet.Cells["D" + (22 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C29"].ToString()); //trợ cấp sinh hoạt

                exSheet.Cells["B" + (23 + (loop_height * (i / 2)))].Value = "Thưởng thành tích";
                exSheet.Cells["C" + (23 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT6"].ToString()); //thưởng thành tích    
                exSheet.Cells["D" + (23 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT6"].ToString()); //thưởng thành tích                  

                exSheet.Cells["B" + (24 + (loop_height * (i / 2)))].Value = "Thưởng sáng kiến";
                exSheet.Cells["C" + (24 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT4"].ToString()); //thưởng sáng kiến
                exSheet.Cells["D" + (24 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT4"].ToString()); //thưởng sáng kiến

                exSheet.Cells["B" + (25 + (loop_height * (i / 2)))].Value = "Thưởng chuyên cần";
                exSheet.Cells["C" + (25 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C9"].ToString()); //thưởng chuyên cần
                exSheet.Cells["D" + (25 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C30"].ToString()); //thưởng chuyên cần
                //Tăng ca
                exSheet.Cells["B" + (26 + (loop_height * (i / 2)))].Value = "Lương tăng ca";
                exSheet.Cells["D" + (26 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C24"].ToString()); //lương tăng ca
                exSheet.Cells["B" + (27 + (loop_height * (i / 2)))].Value = "Trợ cấp ca đêm (x35%)";
                exSheet.Cells["D" + (27 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C25"].ToString()); //trợ cấp ca đêm
                exSheet.Cells["B" + (28 + (loop_height * (i / 2)))].Value = "Phụ cấp tăng ca";
                exSheet.Cells["D" + (28 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C26"].ToString()); //phụ cấp tăng ca
                exSheet.Cells["B" + (29 + (loop_height * (i / 2)))].Value = "21.5% BH (Thử việc)";
                exSheet.Cells["D" + (29 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C31"].ToString()); //thử việc
                exSheet.Cells["B" + (30 + (loop_height * (i / 2)))].Value = "Trợ cấp con nhỏ";
                exSheet.Cells["D" + (30 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["CHILDREN_ALLOW_AMT"].ToString()); //trợ cấp con nhỏ
                exSheet.Cells["B" + (31 + (loop_height * (i / 2)))].Value = "Hoàn trả";
                exSheet.Cells["D" + (31 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ANNUAL_STOP_AMT"].ToString()); //hoàn trả
                exSheet.Cells["B" + (32 + (loop_height * (i / 2)))].Value = "Hoàn trả phép năm";
                exSheet.Cells["D" + (32 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ANNUAL_STOP_AMT"].ToString()); //hoàn trả phép năm
                exSheet.Cells["B" + (33 + (loop_height * (i / 2)))].Value = "Phí công tác";
                exSheet.Cells["D" + (33 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C34"].ToString()); //phí công tác
                exSheet.Cells["A" + (34 + (loop_height * (i / 2)))].Value = "TỔNG LƯƠNG";
                exSheet.Cells["D" + (34 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C35"].ToString())); //tổng lương
                exSheet.Cells["A" + (35 + (loop_height * (i / 2)))].Value = "Lương tăng ca tính thuế";
                exSheet.Cells["D" + (35 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C36"].ToString()); //lương tăng ca tính thuế
                exSheet.Cells["A" + (36 + (loop_height * (i / 2)))].Value = "Giảm trừ gia cảnh";
                exSheet.Cells["D" + (36 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C37"].ToString()); //Giảm trừ gia cảnh
                exSheet.Cells["A" + (37 + (loop_height * (i / 2)))].Value = "THU NHẬP TÍNH THUẾ";
                exSheet.Cells["D" + (37 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C38"].ToString()); //Thu nhập tính thuế
                //Khấu trừ
                exSheet.Cells["B" + (38 + (loop_height * (i / 2)))].Value = "Bảo hiểm xã hội bắt buộc (10,5%)";
                exSheet.Cells["D" + (38 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["BHXH_FULL"].ToString()); //bảo hiểm xã hội bắt buộc
                exSheet.Cells["B" + (39 + (loop_height * (i / 2)))].Value = "Công đoàn";
                exSheet.Cells["D" + (39 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C43"].ToString()); //Công đoàn
                exSheet.Cells["B" + (40 + (loop_height * (i / 2)))].Value = "Thuế thu nhập";
                exSheet.Cells["D" + (40 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C44"].ToString()); //Thuế thu nhập
                exSheet.Cells["B" + (41 + (loop_height * (i / 2)))].Value = "Trừ khác";
                exSheet.Cells["D" + (41 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C46"].ToString()); //Trừ khác
                exSheet.Cells["B" + (42 + (loop_height * (i / 2)))].Value = "TỔNG KHẤU TRỪ";
                exSheet.Cells["D" + (42 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C47"].ToString()); //Tổng khấu trừ
                exSheet.Cells["A" + (43 + (loop_height * (i / 2)))].Value = "TỔNG LƯƠNG THỰC LÃNH";
                exSheet.Cells["D" + (43 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C48"].ToString())); //Tổng lương thực lãnh

                exSheet.Cells["A" + (44 + (loop_height * (i / 2)))].Value = "Ghi chú:số phút vào trễ hoặc ra sớm:" + dt_emp.Rows[i]["C51"].ToString();
                exSheet.Cells["A" + (45 + (loop_height * (i / 2)))].Value = "Cảm ơn anh/chị đã làm việc tích cực";
                exSheet.Cells["A" + (46 + (loop_height * (i / 2)))].Value = "Ghi chú: Trong thời gian thử việc không có phụ cấp sinh hoạt (400000đ)";
                exSheet.Cells["A" + (47 + (loop_height * (i / 2)))].Value = "Hạn cuối cùng nhận thắc mắc là ngày " + dt_emp.Rows[i]["C49"].ToString();             
            }
            else
            {
                exSheet.Cells["F" + (1 + (loop_height * (i / 2)))].Value = "CÔNG TY TNHH SUNG SHIN A VIỆT NAM";
                exSheet.Cells["I" + (1 + (loop_height * (i / 2)))].Value = "No: " + (i + 1);
                exSheet.Cells["F" + (2 + (loop_height * (i / 2)))].Value = "PHIẾU LƯƠNG THÁNG " + dt_emp.Rows[i]["C0"].ToString();
                //Thông tin
                exSheet.Cells["G" + (3 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C1"].ToString();//tên
                exSheet.Cells["H" + (3 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C2"].ToString();//mã nv
                exSheet.Cells["G" + (4 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C3"].ToString();//tên phòng ban
                exSheet.Cells["H" + (4 + (loop_height * (i / 2)))].Value = dt_emp.Rows[i]["C4"].ToString(); //need check
                //Công
                exSheet.Cells["G" + (5 + (loop_height * (i / 2)))].Value = "Tổng công ngày";
                exSheet.Cells["I" + (5 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["work_day"].ToString()); //tổng công ngày
                exSheet.Cells["G" + (6 + (loop_height * (i / 2)))].Value = "Tổng công đêm";
                exSheet.Cells["I" + (6 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["work_day_nt"].ToString()); // tổng công đêm
                exSheet.Cells["G" + (7 + (loop_height * (i / 2)))].Value = "Số ngày nghỉ hưởng lương";
                exSheet.Cells["I" + (7 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C11"].ToString()); //số ngày nghỉ hưởng lương
                exSheet.Cells["G" + (8 + (loop_height * (i / 2)))].Value = "TỔNG NGÀY HƯỞNG LƯƠNG";
                exSheet.Cells["I" + (8 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C12"].ToString()); //TỔNG NGÀY HƯỞNG LƯƠNG
                //Tăng ca
                exSheet.Cells["G" + (9 + (loop_height * (i / 2)))].Value = "Danh mục";
                exSheet.Cells["H" + (9 + (loop_height * (i / 2)))].Value = "Ngày";
                exSheet.Cells["I" + (9 + (loop_height * (i / 2)))].Value = "Đêm";
                exSheet.Cells["G" + (10 + (loop_height * (i / 2)))].Value = "Ngày thường";
                exSheet.Cells["H" + (10 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C14"].ToString()); //Ngày thường ca ngày x150%
                exSheet.Cells["I" + (10 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C15"].ToString()); //Ngày thường ca đêm x185%

                exSheet.Cells["G" + (11 + (loop_height * (i / 2)))].Value = "Sau 22 giờ";
                exSheet.Cells["H" + (11 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C16"].ToString());    //ca ngày sau 22h x200%
                exSheet.Cells["I" + (11 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["NOT_195_2"].ToString()); //ca ngày sau 22h x210%
                exSheet.Cells["G" + (12 + (loop_height * (i / 2)))].Value = "Chủ nhật";
                exSheet.Cells["H" + (12 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C17"].ToString()); //Chủ nhật x200%
                exSheet.Cells["I" + (12 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C18"].ToString()); //Chủ nhật x270%
                exSheet.Cells["G" + (13 + (loop_height * (i / 2)))].Value = "Lễ - Tết";
                exSheet.Cells["H" + (13 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C19"].ToString()); //Lễ - Tết x300%
                exSheet.Cells["I" + (13 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C20"].ToString()); //Lễ - Tết x390%
                exSheet.Cells["G" + (14 + (loop_height * (i / 2)))].Value = "Tổng tăng ca";
                exSheet.Cells["H" + (14 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C22"].ToString()); //Tổng tăng ca
                //Tính lương
                exSheet.Cells["F" + (15 + (loop_height * (i / 2)))].Value = "Tính lương";
                exSheet.Cells["H" + (15 + (loop_height * (i / 2)))].Value = "Đủ tháng";
                exSheet.Cells["I" + (15 + (loop_height * (i / 2)))].Value = "Tháng " + dt_emp.Rows[i]["C0"].ToString().Substring(1, 1);

                exSheet.Cells["G" + (16 + (loop_height * (i / 2)))].Value = "Lương cơ bản";
                exSheet.Cells["H" + (16 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C5"].ToString())); //lương cơ bản full
                exSheet.Cells["I" + (16 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C23"].ToString())); //lương cơ bản thực tế

                exSheet.Cells["G" + (17 + (loop_height * (i / 2)))].Value = "Phụ cấp chức vụ";
                exSheet.Cells["H" + (17 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["ALLOW_AMT5_FULL"].ToString())); //phụ cấp chức vụ
                exSheet.Cells["I" + (17 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["ALLOW_AMT5"].ToString())); //phụ cấp chức vụ

                exSheet.Cells["G" + (18 + (loop_height * (i / 2)))].Value = "Phụ cấp trách nhiệm";
                exSheet.Cells["H" + (18 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C7"].ToString()); //phụ cấp trách nhiệm
                exSheet.Cells["I" + (18 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C28"].ToString()); //phụ cấp trách nhiệm

                exSheet.Cells["G" + (19 + (loop_height * (i / 2)))].Value = "Phụ cấp thâm niên";
                exSheet.Cells["H" + (19 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["SENIOR_AMT"].ToString()); //phụ cấp thâm niên
                exSheet.Cells["I" + (19 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C32"].ToString()); //phụ cấp thâm niên

                exSheet.Cells["G" + (20 + (loop_height * (i / 2)))].Value = "Trợ cấp công việc";
                exSheet.Cells["H" + (20 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C6"].ToString()); //trợ cấp công việc
                exSheet.Cells["I" + (20 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C27"].ToString()); //trợ cấp công việc

                exSheet.Cells["G" + (21 + (loop_height * (i / 2)))].Value = "Trợ cấp ưu đãi";
                exSheet.Cells["H" + (21 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT3"].ToString()); //trợ cấp ưu đãi
                exSheet.Cells["I" + (21 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT3"].ToString()); //trợ cấp ưu đãi

                exSheet.Cells["G" + (22 + (loop_height * (i / 2)))].Value = "Trợ cấp sinh hoạt";
                exSheet.Cells["H" + (22 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C8"].ToString()); //trợ cấp sinh hoạt
                exSheet.Cells["I" + (22 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C29"].ToString()); //trợ cấp sinh hoạt

                exSheet.Cells["G" + (23 + (loop_height * (i / 2)))].Value = "Thưởng thành tích";
                exSheet.Cells["H" + (23 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT6"].ToString()); //thưởng thành tích    
                exSheet.Cells["I" + (23 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT6"].ToString()); //thưởng thành tích                  

                exSheet.Cells["G" + (24 + (loop_height * (i / 2)))].Value = "Thưởng sáng kiến";
                exSheet.Cells["H" + (24 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT4"].ToString()); //thưởng sáng kiến
                exSheet.Cells["I" + (24 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ALLOW_AMT4"].ToString()); //thưởng sáng kiến

                exSheet.Cells["G" + (25 + (loop_height * (i / 2)))].Value = "Thưởng chuyên cần";
                exSheet.Cells["H" + (25 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C9"].ToString()); //thưởng chuyên cần
                exSheet.Cells["I" + (25 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C30"].ToString()); //thưởng chuyên cần
                //Tăng ca
                exSheet.Cells["G" + (26 + (loop_height * (i / 2)))].Value = "Lương tăng ca";
                exSheet.Cells["I" + (26 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C24"].ToString()); //lương tăng ca
                exSheet.Cells["G" + (27 + (loop_height * (i / 2)))].Value = "Trợ cấp ca đêm (x35%)";
                exSheet.Cells["I" + (27 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C25"].ToString()); //trợ cấp ca đêm
                exSheet.Cells["G" + (28 + (loop_height * (i / 2)))].Value = "Phụ cấp tăng ca";
                exSheet.Cells["I" + (28 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C26"].ToString()); //phụ cấp tăng ca
                exSheet.Cells["G" + (29 + (loop_height * (i / 2)))].Value = "21.5% BH (Thử việc)";
                exSheet.Cells["I" + (29 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C31"].ToString()); //thử việc
                exSheet.Cells["G" + (30 + (loop_height * (i / 2)))].Value = "Trợ cấp con nhỏ";
                exSheet.Cells["I" + (30 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["CHILDREN_ALLOW_AMT"].ToString()); //trợ cấp con nhỏ
                exSheet.Cells["G" + (31 + (loop_height * (i / 2)))].Value = "Hoàn trả";
                exSheet.Cells["I" + (31 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ANNUAL_STOP_AMT"].ToString()); //hoàn trả
                exSheet.Cells["G" + (32 + (loop_height * (i / 2)))].Value = "Hoàn trả phép năm";
                exSheet.Cells["I" + (32 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["ANNUAL_STOP_AMT"].ToString()); //hoàn trả phép năm
                exSheet.Cells["G" + (33 + (loop_height * (i / 2)))].Value = "Phí công tác";
                exSheet.Cells["I" + (33 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C34"].ToString()); //phí công tác
                exSheet.Cells["F" + (34 + (loop_height * (i / 2)))].Value = "TỔNG LƯƠNG";
                exSheet.Cells["I" + (34 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C35"].ToString())); //tổng lương
                exSheet.Cells["F" + (35 + (loop_height * (i / 2)))].Value = "Lương tăng ca tính thuế";
                exSheet.Cells["I" + (35 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C36"].ToString()); //lương tăng ca tính thuế
                exSheet.Cells["F" + (36 + (loop_height * (i / 2)))].Value = "Giảm trừ gia cảnh";
                exSheet.Cells["I" + (36 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C37"].ToString()); //Giảm trừ gia cảnh
                exSheet.Cells["F" + (37 + (loop_height * (i / 2)))].Value = "THU NHẬP TÍNH THUẾ";
                exSheet.Cells["I" + (37 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C38"].ToString()); //Thu nhập tính thuế
                //Khấu trừ
                exSheet.Cells["G" + (38 + (loop_height * (i / 2)))].Value = "Bảo hiểm xã hội bắt buộc (10,5%)";
                exSheet.Cells["I" + (38 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["BHXH_FULL"].ToString()); //bảo hiểm xã hội bắt buộc
                exSheet.Cells["G" + (39 + (loop_height * (i / 2)))].Value = "Công đoàn";
                exSheet.Cells["I" + (39 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C43"].ToString()); //Công đoàn
                exSheet.Cells["G" + (40 + (loop_height * (i / 2)))].Value = "Thuế thu nhập";
                exSheet.Cells["I" + (40 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C44"].ToString()); //Thuế thu nhập
                exSheet.Cells["G" + (41 + (loop_height * (i / 2)))].Value = "Trừ khác";
                exSheet.Cells["I" + (41 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C46"].ToString()); //Trừ khác
                exSheet.Cells["G" + (42 + (loop_height * (i / 2)))].Value = "TỔNG KHẤU TRỪ";
                exSheet.Cells["I" + (42 + (loop_height * (i / 2)))].Value = Double.Parse(dt_emp.Rows[i]["C47"].ToString()); //Tổng khấu trừ
                exSheet.Cells["F" + (43 + (loop_height * (i / 2)))].Value = "TỔNG LƯƠNG THỰC LÃNH";
                exSheet.Cells["I" + (43 + (loop_height * (i / 2)))].Value = Double.Parse((dt_emp.Rows[i]["C48"].ToString())); //Tổng lương thực lãnh

                exSheet.Cells["F" + (44 + (loop_height * (i / 2)))].Value = "Ghi chú:số phút vào trễ hoặc ra sớm:" + dt_emp.Rows[i]["C51"].ToString();
                exSheet.Cells["F" + (45 + (loop_height * (i / 2)))].Value = "Cảm ơn anh/chị đã làm việc tích cực";
                exSheet.Cells["F" + (46 + (loop_height * (i / 2)))].Value = "Ghi chú: Trong thời gian thử việc không có phụ cấp sinh hoạt (400000đ)";
                exSheet.Cells["F" + (47 + (loop_height * (i / 2)))].Value = "Hạn cuối cùng nhận thắc mắc là ngày " + dt_emp.Rows[i]["C49"].ToString();           
            }

            
        }
            
        exBook.SaveAs(TempFile);

        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
}