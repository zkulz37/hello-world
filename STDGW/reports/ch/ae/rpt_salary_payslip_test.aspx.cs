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

public partial class rpt_salary_payslip_test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        //url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?TCO_ORG_PK=' + lstOrg_Code.value + '&THR_WG_PK=' + lstGrp_Code.value + '&NATION=' + lst_nation.value;
        string TCO_ORG_PK;
        string THR_WG_PK;
        string NATION;
        string WORK_MON = "201611";
        int irow; //dòng
        int icol_emp; //cột
        int pos = 6; //position : vị trí con trỏ trong excel 
        int loop_height = 35;
        int loop_width = 5;
        TCO_ORG_PK = Request["TCO_ORG_PK"].ToString();
        THR_WG_PK = Request["THR_WG_PK"].ToString();
        NATION = Request["NATION"].ToString();


        //create template file
        string TemplateFile = "rpt_salary_payslip_test.xls";
        string TempFile = "../../../system/temp/rpt_salary_payslip_test" + DateTime.Now.ToString("hhmmss") + Session["User_ID"].ToString() + ".xls";
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
        pbs.Reset();


        string SQL =
        "select  " +
        "    to_char(to_date(B.WORK_MON,'YYYYMM'),'MM-YYYY') as WORK_MON, " +
        "    A.EMP_ID, " +
        "    A.PK, " +
        "    A.FULL_NAME, " +
        "    A.PHOTO_PK, " +
        "    A.STATUS, " +
        "   B.DEPT_NM, "+
        "    to_char(to_date(A.JOIN_DT,'YYYYMMDD'),'DD-MM-YYYY') as JOIN_DT, " +
        "    to_char(to_date(A.LEFT_DT,'YYYYMMDD'),'DD-MM-YYYY') as LEFT_DT, " +
        "    A.SEX, " +
        "    A.NATION, " +
        "    A.PRESENT_ADDR, " +
        "    A.TEL, " +
        "    A.BASIC_SAL, " +
        "    A.TCO_ORG_PK, " +
        "    ROUND (NVL (B.SALARY_LEVEL1, 0), 3) as PROBATION_SALARY,  " +         //-- luong thu viec 
        "    ROUND (NVL (B.SALARY_LEVEL2, 0), 3) as OFFICIAL_SALARY,     " +        // -- luong chinh thuc 
        "    ROUND (NVL (B.ALLOW_AMT1, 0), 3) as ALLOW_AMT1,            " +         //-- phu cap chuc vu
        "    ROUND (NVL (B.ALLOW_AMT2, 0), 3) as ALLOW_AMT2,            " +         //-- phu cap tien an
        "    ROUND (NVL (B.ALLOW_AMT1_L2, 0), 3) as ALLOW_AMT1_L2, " +
        "    ROUND (NVL (B.ALLOW_AMT2_L2, 0), 3) as ALLOW_AMT2_L2, " +
        " ROUND (NVL (B.ALLOW_AMT1_L1, 0) + NVL(B.ALLOW_AMT2_L1,0),3) AS PC_PROBATION," +   // tong phu cap thu viec
        " ROUND (NVL (B.ALLOW_AMT1_L2, 0) + NVL(B.ALLOW_AMT2_L2,0),3) AS PC_OFFICIAL," +    // tong phu cap chinh thuc
        "    ROUND (NVL (B.WT_L1, 0) + NVL (B.HOL_DAY_L1, 0) * 8, 3) as WT_L1, " +
        "    ROUND (NVL (B.WT_L2, 0) + NVL (B.HOL_DAY_L2, 0) * 8, 3) as Working_Days,  " +  //-- Ngày công
        "    ROUND (NVL (B.WT_L1_AMT, 0)+ NVL (B.HOL_DAY_L1_AMT, 0)+ NVL (B.WT_L2_AMT, 0)+ NVL (B.HOL_DAY_L2_AMT, 0),3) as BASIC_SALARY,  " +   //-- ngay cong qui ra tien
        "    ROUND (NVL (B.ABS_ALE_L1, 0), 3) as ALE_ABS,   " +             //-- Nghỉ phép năm 
        "    ROUND (NVL (B.ABS_ALE_L2, 0), 3) as OTHER_ABS,   " +           //-- Ngày vắng khác
        "    ROUND (NVL (B.ABS_ALE_L1_AMT, 0) + NVL (B.ABS_ALE_L2_AMT, 0), 3) as ABS_AMT,   " +       //  -- Nghỉ phép qui ra tiền
        "     ROUND (NVL (B.ABS_OTHER_PAY_L1, 0), 3), " +
        "         ROUND (NVL (B.ABS_OTHER_PAY_L2, 0), 3), " +
        "         ROUND ( " +
        "            NVL (B.ABS_OTHER_PAY_L1_AMT, 0) + NVL (B.ABS_OTHER_PAY_L2_AMT, 0), " +
        "            3), " +
        "         ROUND (NVL (B.OT_L1, 0), 3), " +
        "         ROUND (NVL (B.OT_L2, 0), 3) as OT_1,   " +                // -- Tăng ca thường (Overtime 1.5)
        "         ROUND (NVL (B.OT_L1_AMT, 0) + NVL (B.OT_L2_AMT, 0), 3) as OT_1_AMT,   " +         //-- Tăng ca qui ra tiền
        "         ROUND ( " +
        "              NVL (B.ST_L1, 0) " +
        "            + NVL (B.HT_L1, 0) " +
        "            + NVL (B.OHT_L1, 0) " +
        "            + NVL (B.OST_L1, 0), " +
        "            3), " +
        "         ROUND ( " +
        "              NVL (B.ST_L2, 0) " +
        "            + NVL (B.HT_L2, 0) " +
        "            + NVL (B.OHT_L2, 0) " +
        "            + NVL (B.OST_L2, 0), " +
        "            3) as OT_2,     " +                //-- Tăng ca CN/Lễ (Overtime 2.0)
        "         ROUND ( " +
        "              NVL (B.ST_L1_AMT, 0) " +
        "            + NVL (B.HT_L1_AMT, 0) " +
        "            + NVL (B.OHT_L1_AMT, 0) " +
        "            + NVL (B.ST_L2_AMT, 0) " +
        "            + NVL (B.HT_L2_AMT, 0) " +
        "            + NVL (B.OHT_L2_AMT, 0) " +
        "            + NVL (B.OST_L1_AMT, 0) " +
        "            + NVL (B.OST_L2_AMT, 0), " +
        "            3) as OT_2_AMT,   " +              //-- Tăng ca qui ra tiền
        "         ROUND (NVL (B.NT_30_L1, 0), 3) as PC_NT,  " +         // -- PC ca đêm
        "         ROUND (NVL (B.NT_30_L2, 0), 3),                                     " +
        "         ROUND (NVL (B.NT_30_L1_AMT, 0) + NVL (B.NT_30_L2_AMT, 0), 3), " +
        "         ROUND (NVL (B.NT_45_L1, 0) + NVL (B.NT_45_2_L1, 0), 3), " +
        "         ROUND (NVL (B.NT_45_L2, 0) + NVL (B.NT_45_2_L2, 0), 3), " +
        "         ROUND ( " +
        "              NVL (B.NT_45_L1_AMT, 0) " +
        "            + NVL (B.NT_45_L2_AMT, 0) " +
        "            + NVL (B.NT_45_2_L1_AMT, 0) " +
        "            + NVL (B.NT_45_2_L2_AMT, 0), " +
        "            3), " +
        "         ROUND (NVL (B.NT_60_L1, 0), 3), " +
        "         ROUND (NVL (B.NT_60_L2, 0), 3) as PC_OST,   " +               //-- Phụ cấp tăng ca đêm CN
        "         ROUND (NVL (B.NT_60_L1_AMT, 0) + NVL (B.NT_60_L2_AMT, 0), 3) as PC_OST_AMT,  " +      //-- PCTC qui ra tiền
        "         ROUND (NVL (B.NT_90_L1, 0), 3),                                                             " +
        "         ROUND (NVL (B.NT_90_L2, 0), 3) as PC_OHT,   " +           //-- PCTC đêm lễ
        "         ROUND (NVL (B.NT_90_L1_AMT, 0) + NVL (B.NT_90_L2_AMT, 0), 3) as PC_OHT_AMT,   " +     //-- qui ra tiền
        "         ROUND (NVL (B.ALLOW_K1_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K2_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K3_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K4_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K5_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K6_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K7_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_K8_AMT, 0), 3), " +
        "         ROUND (NVL (B.RETURN_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALE_STOP, 0), 3), " +
        "         ROUND (NVL (B.ALE_STOP_AMT, 0), 3), " +
        "         ROUND (NVL (B.SEVERANCE_MONTH, 0), 3), " +
        "         ROUND (NVL (B.SEVERANCE_AMT, 0), 3), " +
        "         ROUND (NVL (B.GROSS_AMT, 0), 3) as GROSS_SALARY,  " +         // -- Lương Gross
        "         ROUND (NVL (B.BREAK_CONTRACT_DAYS, 0), 3), " +
        "         ROUND (NVL (B.BREAK_CONTRACT_AMT, 0), 3), " +
        "         ROUND (NVL (B.ADVANCE_AMT, 0), 3), " +
        "         ROUND (NVL (B.INCOME_BEFORE_TAX, NVL (B.INCOME_AMT, 0)), 3), " +
        "         ROUND (NVL (B.INCOME_TAX, 0), 3) as INCOME_TAX, " +           // thue thu nhap
        "         ROUND (NVL (B.UNION_AMT, 0), 3) as CONG_DOAN, " +             //cong doan
        "         ROUND (NVL (B.SOCIAL_AMT, 0) + NVL (B.HEALTH_AMT, 0), 3) as BHXH_BHYT,  " +       //-- BHXH _ BHYT
        "         ROUND (NVL (B.RETURN_NO_PIT, 0), 3), " +
        "         ROUND (NVL (B.ADVANCE_NO_PIT, 0), 3), " +
        "         DECODE ('01', " +
        "                 'ALL', ROUND (NVL (B.NET_amt, 0), 0), " +
        "                 '01', ROUND (NVL (B.NET_amt, 0), 0), " +
        "                 ROUND (NVL (B.NET_AMT, 0), 2)) as NET_SALARY, " +             // --Lương NET
        "         ROUND (NVL (B.UNEMP_INS, 0), 3) as BHTN,  " +         //-- BH thất nghiệp 
        "         ROUND (NVL (B.OT_TAX_L1_AMT, 0) + NVL (B.OT_TAX_L2_AMT, 0), 3) as OT_SLARY,  " +      //-- Tăng ca 100% qui ra tiền
        "         ROUND (NVL (B.DEDUCT_PIT, 0), 3) as DEDUCT_PIT,   " +     //-- Giảm trừ thuế
        "         ROUND (NVL (B.INC_AMT, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT1_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT2_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT3_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT4_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT5_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT6_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT7_L1, 0), 3), " +
        "         ROUND (NVL (B.ALLOW_AMT8_L1, 0), 3),  " +
        "  B.HEALTH_CARD_AMT   " +                          // tru the BH
        "from THR_EMPLOYEE a " +
        "left join THR_MONTH_SALARY b on A.EMP_ID = B.EMP_ID and A.DEL_IF = B.DEL_IF " +
        "where  " +
        "    A.DEL_IF = 0 " +
        "    and B.WORK_MON =  '"+ WORK_MON + "'"+
        " and ( A.TCO_ORG_PK in (select g.pk from tco_org g where g.del_if = 0 " +
        " start with g.pk = decode ('" + TCO_ORG_PK + "','ALL',0,'" + TCO_ORG_PK + "')" +
        " connect by prior g.pk = g.p_pk) or + '" + TCO_ORG_PK + "' = 'ALL' )" +
         "       and decode( '" + THR_WG_PK + "', 'ALL', 'ALL', A.THR_WG_PK ) = '" + THR_WG_PK + "' " +
         "       and decode( '" + NATION + "', 'ALL', 'ALL', A.NATION ) = '" + NATION + "'";
        //Read SQL
        //Response.Write(SQL);
        //Response.End();
        
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);

        irow = dt_emp.Rows.Count; //đếm tổng số dòng
        icol_emp = dt_emp.Columns.Count; //đếm tổng số cột    

        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }


        //Insert row as same : Range nhận 2 tham số, sử dụng trong report liệt kê danh sách theo thứ tự
       //  for (int i = 0; i < irow - 1; i++)
        //{
          //  exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        //}



        //Insert data like form : Range nhận 4 tham số : khoanh vùng một khoảng trong excel . tiếp đó sử dụng copy-pase 
        // Sử dụng khi cần report xuất phiếu
        for (int i = 1; i < irow; i++)
        {
            //
            exSheet.Range[1, 1, loop_height, loop_width].Copy(exSheet.Range[(i) * loop_height, 1, (i + 1) * loop_height, loop_width], XlPasteType.xlPasteAll);
            for (int j = 1; j < loop_width; j++)
            {
                exSheet.Range[(loop_height * i) + j, 1].RowHeight = exSheet.Range[j, 1].RowHeight;
            }
        }


        //
 
        for (int i = 0; i < irow; i++)
        {
           

            {
                exSheet.Cells["A" + (2 + (loop_height * i))].Value = "PAY SLIP IN " + dt_emp.Rows[i]["WORK_MON"].ToString() + " (PHIẾU LƯƠNG THÁNG " + dt_emp.Rows[i]["WORK_MON"].ToString() + ")";
                exSheet.Cells["A" + (3 + (loop_height * i))].Value = "Họ tên: " + dt_emp.Rows[i]["FULL_NAME"].ToString();
                exSheet.Cells["A" + (4 + (loop_height * i))].Value = "Mã NV :" + dt_emp.Rows[i]["EMP_ID"].ToString();
                exSheet.Cells["A" + (5 + (loop_height * i))].Value = "Ngày vào :" + dt_emp.Rows[i]["JOIN_DT"].ToString();
                exSheet.Cells["C" + (4 + (loop_height * i))].Value = "Bộ phận :" + dt_emp.Rows[i]["DEPT_NM"].ToString();
                exSheet.Cells["C" + (5 + (loop_height * i))].Value = "Ngày nghỉ việc :" + dt_emp.Rows[i]["LEFT_DT"].ToString();
                exSheet.Cells["B" + (7 + (loop_height * i))].Value = dt_emp.Rows[i]["PROBATION_SALARY"].ToString(); //luong co ban thu viec
                exSheet.Cells["E" + (7 + (loop_height * i))].Value = dt_emp.Rows[i]["OFFICIAL_SALARY"].ToString();  //luong co ban chinh thuc
                exSheet.Cells["B" + (8 + (loop_height * i))].Value = dt_emp.Rows[i]["PC_PROBATION"].ToString();  //Tổng phụ cấp thử việc (Probation allowance)   B8  PC_PROBATION 
                exSheet.Cells["E" + (8 + (loop_height * i))].Value = dt_emp.Rows[i]["PC_OFFICIAL"].ToString();     //Tổng phụ cấp chính thức (Official Allowance)	E8  PC_OFFICIAL
                //Ngày công trong tháng (Working day of month)
                //Ngày công thực tế (Real working day)	
                exSheet.Cells["C" + (13 + (loop_height * i))].Value = dt_emp.Rows[i]["Working_Days"].ToString();  //Lương ngày công (Basic salary) (Giờ )
                exSheet.Cells["E" + (13 + (loop_height * i))].Value = dt_emp.Rows[i]["BASIC_SALARY"].ToString();  //Thành tiền
                exSheet.Cells["C" + (14 + (loop_height * i))].Value = dt_emp.Rows[i]["ALE_ABS"].ToString();       //Nghỉ phép năm (ALE Absence)
                exSheet.Cells["E" + (14 + (loop_height * i))].Value = dt_emp.Rows[i]["ABS_AMT"].ToString();       //Thành tiền
                exSheet.Cells["C" + (15 + (loop_height * i))].Value = dt_emp.Rows[i]["OTHER_ABS"].ToString();     //Ngày vắng khác
                //Thành tiền ngày vắng khác
                exSheet.Cells["C" + (16 + (loop_height * i))].Value = dt_emp.Rows[i]["OT_1"].ToString();          // Tăng ca thường
                exSheet.Cells["E" + (16 + (loop_height * i))].Value = dt_emp.Rows[i]["OT_1_AMT"].ToString();      // Thành tiền tăng ca thường
                exSheet.Cells["C" + (17 + (loop_height * i))].Value = dt_emp.Rows[i]["OT_2"].ToString();      //Tăng ca CN (Sunday OT 2.0)
                exSheet.Cells["E" + (17 + (loop_height * i))].Value = dt_emp.Rows[i]["OT_2_AMT"].ToString();      //Thành tiền tăng ca CN (Sunday OT 2.0)
                //Tăng ca Lễ (Holiday OT 3.0)
                //Thành tiền tăng ca Lễ (Holiday OT 3.0)
                //Tổng Lương ngày công và phụ cấp (Total of Basic salary and allowance)	 D20
                exSheet.Cells["C" + (23 + (loop_height * i))].Value = dt_emp.Rows[i]["INCOME_TAX"].ToString();   //Thu nhập chịu thuế(Payable Income)  C23  INCOME_TAX
                //Vi phạm HĐ (Break Contract) số ngày : C24
                //Vi phạm HĐ (Break Contract) số tiền : E24
                exSheet.Cells["C" + (25 + (loop_height * i))].Value = dt_emp.Rows[i]["BHXH_BHYT"].ToString();  //BHXH & BHYT (Insurance AMT)
                exSheet.Cells["C" + (26 + (loop_height * i))].Value = dt_emp.Rows[i]["BHTN"].ToString();   //BH Thất nghiệp (Unemployee Ins (1%))  : C26  BHTN
                exSheet.Cells["C" + (27 + (loop_height * i))].Value = dt_emp.Rows[i]["CONG_DOAN"].ToString();    //Tiền công đoàn (Trade Union) : C27
                exSheet.Cells["C" + (28 + (loop_height * i))].Value = dt_emp.Rows[i]["HEALTH_CARD_AMT"].ToString();    //Trừ thẻ Bảo hiểm (Deduct Health card) : C28   HEALTH_CARD_AMT
                exSheet.Cells["C" + (29 + (loop_height * i))].Value = dt_emp.Rows[i]["INCOME_TAX"].ToString();  //Thuế thu nhập (Income Tax) : C29
                //Trừ khác (Other Ded (No PIT)) : C30
                exSheet.Cells["B" + (31 + (loop_height * i))].Value = dt_emp.Rows[i]["DEDUCT_PIT"].ToString();  //Tổng khấu trừ (Total Deduct) : B31  DEDUCT_PIT
                exSheet.Cells["C" + (33 + (loop_height * i))].Value = dt_emp.Rows[i]["NET_SALARY"].ToString(); //Thực lãnh (Net Salary) : C33
                //Phép năm còn lại tính đến tháng hiện tại (Remaining A.L) : D34
					
            }
            if (i != 0) 
            {
                pbs.Add(usedrange.Rows[(loop_height) * (i)]); //code phân trang 
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