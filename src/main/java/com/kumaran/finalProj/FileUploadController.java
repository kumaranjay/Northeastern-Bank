package com.kumaran.finalProj;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

import com.kumaran.finalProj.model.ChequeFile;

@SuppressWarnings("deprecation")
public class FileUploadController extends SimpleFormController{
	
	public FileUploadController(){
		setCommandClass(ChequeFile.class);
		setCommandName("cheque");
		setFormView("depositCheck");
		setSuccessView("depositCheckSuccess");
	}
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request,
		HttpServletResponse response, Object command, BindException errors)
		throws Exception {
 
		ChequeFile chequeFile = (ChequeFile)command;
 
		String path = getServletContext().getRealPath("");
		CommonsMultipartFile cmf = chequeFile.getImage();
		File dest = new File("C:\\Users\\Kumaran\\OneDrive\\Web Tools\\Final_Project_Kumaran_Jayasankaran\\src\\main\\webapp\\resources\\uploads\\",cmf.getOriginalFilename());
		chequeFile.getImage().transferTo(dest);
		
 
//		if(multipartFile!=null){
//			fileName = multipartFile.getOriginalFilename();
//			//do whatever you want
//		}
 
		return new ModelAndView(getSuccessView());
	}
}
