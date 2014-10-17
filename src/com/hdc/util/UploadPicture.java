/**
 * Project Name:Banquet
 * File Name:UploadPicture.java
 * Package Name:com.hdc.util
 * Date:2014-4-20上午10:40:30
 *
 */
package com.hdc.util;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

/**
 * @ClassName: UploadPicture
 * @Description:TODO(上传图片)
 * @author: zml
 * @date: 2014-4-20 上午10:40:30
 *
 */
public class UploadPicture {
	//image/jpeg,image/jpg,image/bmp,image/gif,image/png,image/pjpeg,image/x-png
	private static final String PICTURE_TYPE = "image/jpeg,image/jpg,image/bmp,image/gif,image/png,image/pjpeg,image/x-png";
	public String uploadPic(MultipartFile file, String picType, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException{
		String newURL = "";
		String user_id = (String) request.getSession().getAttribute("user_id");
		String contentType = file.getContentType();
		if(PICTURE_TYPE.contains(contentType)){
			String pic_path = request.getSession().getServletContext().getRealPath("UploadFile");
			Date nowTime = new Date();
			String timestamp = DateUtil.DateToString(nowTime, "yyyyMMddHHmmss"); 
			String file_path = "/UserFiles/"+user_id+"/"+picType+"/";
			File myFilePath = new File(pic_path+file_path);
			//文件夹是否已存在，不可使用exists()方法  
			if (!myFilePath.exists()) {  
				myFilePath.mkdirs();
			}
			String tempName = file.getOriginalFilename();
			//文件后缀
			String appden = tempName.substring(tempName.lastIndexOf('.'));
			String fileName = timestamp+appden;
			//C:\Tomcat\webapps\Banquet\UploadFile
			file.transferTo(new File(pic_path+file_path+fileName));
			String ContextPath = request.getContextPath();
			newURL = "UploadFile"+file_path+fileName;
			//newURL = ContextPath+"/UploadFile"+file_path+fileName;
			//System.out.println("newURL: "+newURL);
			response.getWriter().print("<script>alert('上传成功！');</script>");
		}else{
			response.getWriter().print("<script>alert('图片格式不正确！');</script>");
		}
		return newURL;
		
	}
}
