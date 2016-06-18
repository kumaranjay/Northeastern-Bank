package com.kumaran.finalProj;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.lang.Object;

import javax.imageio.ImageIO;
import javax.mail.Session;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.github.sarxos.webcam.Webcam;
import com.github.sarxos.webcam.WebcamPanel;
import com.github.sarxos.webcam.WebcamResolution;
import com.google.code.geocoder.Geocoder;
import com.google.code.geocoder.GeocoderRequestBuilder;
import com.google.code.geocoder.model.GeocodeResponse;
import com.google.code.geocoder.model.GeocoderRequest;
import com.google.code.geocoder.model.GeocoderResult;
import com.google.code.geocoder.model.GeocoderStatus;
import com.google.code.geocoder.model.LatLng;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Header;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.html.WebColors;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.kumaran.finalProj.dao.TellerDao;
import com.kumaran.finalProj.dao.UserDao;
import com.kumaran.finalProj.model.ChequeFile;
import com.kumaran.finalProj.model.ChequeImage;
import com.kumaran.finalProj.model.Contacts;
import com.kumaran.finalProj.model.MoneyTransaction;
import com.kumaran.finalProj.model.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	// private ServletContext servletContext;

	@Autowired
	private UserDao userDao;

	@Autowired
	private TellerDao tellerDao;
	
	@Autowired
	ServletContext servletContext;

	// @Autowired
	// @Qualifier("userValidator")
	// private Validator validator;
	//
	// @InitBinder("user")
	// private void initBinder(WebDataBinder binder) {
	// binder.setValidator(validator);
	// }

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	HttpSession session;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {

		String userNameCookie = null;
		String userPasswordCookie = null;
		User user = new User();

		Cookie[] cookies = request.getCookies();

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("userNameCookie")) {
					userNameCookie = cookies[i].getValue();
				} else if (cookies[i].getName().equals("userPasswordCookie")) {
					userPasswordCookie = cookies[i].getValue();
				}
			}
			try {
				User u = userDao.queryUserByNameAndPassword(userNameCookie,
						userPasswordCookie);
				if (u != null) {
					request.getSession().setAttribute("user", u);
					model.addAttribute("user", u);

					if (u.getUserType().equalsIgnoreCase("Customer")) {
						return "customerWelcome";
					} else {
						return "tellerHomePage";
					}
				} else {
					return "homePage";
				}
			} catch (Exception e) {
			}
		}
		return "homePage";
	}

	@RequestMapping(value = "goToRegister")
	public String goToRegister(Model model) {
		User user = new User();
		model.addAttribute("user", user);
		return "register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(Model model, User user, BindingResult result,
			@RequestParam("password") String password,
			HttpServletRequest request) {

		user.setPassword(password);
		user.setActive(1);

		try {
			if (isEmailExisting) {
				model.addAttribute("error",
						"This Email is already registered with us");
				isEmailExisting = false;
				return "adminPage";
			}

			if (isUserNameExisting) {
				model.addAttribute("error", "This UserName is not available");
				isUserNameExisting = false;
				return "adminPage";
			}

			int rv = userDao.registerUser(user);
			session = request.getSession();
			session.setAttribute("user", user);
			User u = new User();
			model.addAttribute("user", u);
			if (rv == 1) {
				model.addAttribute("success", 1);
				return "adminPage";
			} else if (rv == -1) {
				model.addAttribute("errorBand", 1);
				return "adminPage";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "adminPage";

	}

	private boolean isEmailExisting = false;
	private boolean isUserNameExisting = false;

	@RequestMapping(value = "checkExistingEmail")
	public @ResponseBody String checkExistingEmail(HttpServletRequest request) {

		String email = request.getParameter("email");

		String rv = userDao.checkExistingEmail(email);

		if (rv.equals("available")) {
			isEmailExisting = true;
		} else {
			isEmailExisting = false;
		}

		return rv;
		
	}

	@RequestMapping(value = "checkExistingUserName")
	public @ResponseBody String checkExistingUserName(HttpServletRequest request) {

		String userName = request.getParameter("userName");

		String rv = userDao.checkExistingUserName(userName);

		if (rv.equals("available")) {
			isUserNameExisting = true;
		} else {
			isUserNameExisting = false;
		}

		return rv;

	}

	@RequestMapping(value = "confirmRegistration", method = RequestMethod.POST)
	public String confirmRegistration(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		int pin = Integer.parseInt(request.getParameter("pin"));

		if (pin == user.getPin()) {
			user.setActive(1);
			return "registrationSuccess";
		} else {
			String error = "Incorrect PIN. Please enter the correct PIN";
			model.addAttribute("error", error);
			return "confirmRegistration";

		}
	}

	@RequestMapping(value = "login")
	public String login(Model model, HttpServletRequest request,
			HttpServletResponse response) {

		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		String remember = request.getParameter("remember");

		// if(result.hasErrors()){
		// String error = "Invalid Username and Password";
		// model.addAttribute("error", error);
		// return "homePage";
		// }

		try {

			if (userName.equals("admin") && password.equals("admin")) {
				User user = new User();
				model.addAttribute("user", user);
				return "adminPage";
			}

			User user = userDao.queryUserByNameAndPassword(userName, password);

			if (user == null) {
				String error = "Invalid Username and Password";
				model.addAttribute("error", error);
				return "homePage";
			}
			if (user.getActive() == 0) {
				String error = "Account blocked due to 3 wrong attempts";
				model.addAttribute("error", error);
				return "homePage";
			}

			/* save cookies */
			if (remember != null && remember.equalsIgnoreCase("remember")) {
				Cookie userNameCookie = new Cookie("userNameCookie",
						user.getUserName());
				userNameCookie.setMaxAge(1800);
				response.addCookie(userNameCookie);
				Cookie userPasswordCookie = new Cookie("userPasswordCookie",
						user.getPassword());
				userPasswordCookie.setMaxAge(1800);
				response.addCookie(userPasswordCookie);
			}

			if (user.getUserType().equalsIgnoreCase("Customer")) {
				model.addAttribute("user", user);
				request.getSession().setAttribute("user", user);
				saveCookies(user, remember);
				return "customerWelcome";
			} else if (user.getUserType().equalsIgnoreCase("Teller")) {
				int pendingCheques = tellerDao.getChequesToTeller();
				model.addAttribute("pendingCheques", pendingCheques);
				model.addAttribute("user", user);
				request.getSession().setAttribute("user", user);
				saveCookies(user, remember);
				return "tellerHomePage";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "homePage";
	}

	public void saveCookies(User user, String remember) {

	}

	@RequestMapping(value = "tellerHomePage")
	public String tellerHomePage(Model model, HttpServletRequest request) {

		int pendingCheques = tellerDao.getChequesToTeller();
		model.addAttribute("pendingCheques", pendingCheques);
		return "tellerHomePage";

	}

	@RequestMapping(value = "customerWelcome")
	public String customerWelcome(Model model, HttpServletRequest request) {
		// HttpSession session = request.getSession();
		// request.setAttribute("user", session.getAttribute("user"));
		model.addAttribute("user", request.getSession().getAttribute("user"));
		return "customerWelcome";

	}

	@RequestMapping(value = "accountStatement")
	public String accountSummary(Model model, HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		User u;
		try {
			u = userDao.queryUserByNameAndPassword(user.getUserName(),
					user.getPassword());
			List<MoneyTransaction> transactions = u.getMoneyTransactions();
			model.addAttribute("user", u);
			model.addAttribute("transactions", transactions);
			return "accountStatement";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "accountStatement";

	}

	@RequestMapping(value = "transferMoney")
	public String transferMoney(Model model, HttpServletRequest request) {

		return "transferMoney";
	}

	@RequestMapping(value = "transferMoneyToEU")
	public String transferMoneyToEU(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		if (user.getContacts() == null) {
			return "noContacts";
		}
		int size = user.getContacts().size();
		model.addAttribute("user", user);
		model.addAttribute("size", size);
		model.addAttribute("contacts", user.getContacts());
		return "transferMoneyToEU";
	}

	@RequestMapping(value = "sendMoney")
	public String sendMoney(Model model, HttpServletRequest request) {

		String email = (String) request.getParameter("receiver");
		float amount = Float.parseFloat(request.getParameter("amount"));
		String note = (String) request.getParameter("note");

		User user = (User) request.getSession().getAttribute("user");

		MoneyTransaction moneyTransaction = new MoneyTransaction();
		moneyTransaction.setAmount(amount);
		moneyTransaction.setNote(note);
		moneyTransaction.setDate(new Date());
		moneyTransaction.setType("Debit");
		moneyTransaction.setStatus("Approved");
		moneyTransaction.setUser(user);

		int r = userDao.sendMoney(moneyTransaction);

		if (r == -1) {
			return "transferMoney";
		}
		request.getSession().setAttribute("moneyTransaction", moneyTransaction);
		request.getSession().setAttribute("receiverEmail", email);

		return "confirmOTP";

	}

	@RequestMapping(value = "sendMoneyConfirm")
	public @ResponseBody String sendMoneyConfirm(Model model,
			HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		String receiverEmail = (String) request.getSession().getAttribute(
				"receiverEmail");
		MoneyTransaction t = (MoneyTransaction) request.getSession()
				.getAttribute("moneyTransaction");

		int pin = Integer.parseInt(request.getParameter("pin"));

		if (t.getPin() == pin) {
			try {
				userDao.saveTransaction(t, user, receiverEmail);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "transactionSuccess";
		} else {
			// String error = "Incorrect OTP";
			// model.addAttribute("error", error);
			return "error";
		}
	}

	@RequestMapping(value = "depositCheck")
	public String deposit(Model model, HttpServletRequest request) {
		return "depositCheck";
	}

	// @Override
	// public void setServletContext(ServletContext servletContext) {
	// // TODO Auto-generated method stub
	// this.servletContext = servletContext;
	//
	// }

	@RequestMapping(value = "uploadChequePage")
	public String ucp(Model model) {
		ChequeFile cheque = new ChequeFile();
		model.addAttribute("cheque", cheque);
		return "uploadChequePage";
	}

	@RequestMapping(value = "uploadCheque")
	public String upload(Model model, ChequeFile cheque,
			HttpServletRequest request) throws IllegalStateException,
			IOException {

		User user = (User) request.getSession().getAttribute("user");
		CommonsMultipartFile image = cheque.getImage();

		if (image.isEmpty()) {
			ChequeFile cheque2 = new ChequeFile();
			model.addAttribute("cheque", cheque2);
			model.addAttribute("error", "Please Select a File");
			return "uploadChequePage";
		}

		int randomName = (int) (Math.random() * 9999) + 1000;
		String newName = randomName + ".jpg";

		new File("C:\\Users\\Kumaran\\OneDrive\\Web Tools\\Final_Project_Kumaran_Jayasankaran"
						+ "\\src\\main\\webapp\\resources\\uploads\\"
						+ user.getUserName()).mkdir();
		File dest = new File(
				"C:\\Users\\Kumaran\\OneDrive\\Web Tools\\Final_Project_Kumaran_Jayasankaran"
						+ "\\src\\main\\webapp\\resources\\uploads\\"
						+ user.getUserName() + "\\", newName);
		cheque.getImage().transferTo(dest);

		/* adding reference to DB */
		ChequeImage chequeImage = new ChequeImage();
		chequeImage.setFileName(newName);
		chequeImage.setUserName(user.getUserName());
		chequeImage.setApproved(0);
		chequeImage.setUploadDate(new Date());
		userDao.addChequeToDB(chequeImage);

		if (image.getSize() != 0) {
			// // ChequeFile chequeFile = new ChequeFile();
			// // chequeFile.setImage(image);
			// long size = image.getSize();
			// String oname = image.getOriginalFilename();
			// String name = image.getName();
			// model.addAttribute("path", servletContext.getRealPath("/"));
			// model.addAttribute("size", size);
			// model.addAttribute("oname", oname);
			// model.addAttribute("name", name);
			ChequeFile cheque3 = new ChequeFile();
			model.addAttribute("cheque", cheque3);
			model.addAttribute("success", "Upload done successfully");
			return "uploadChequePage";

		}

		return "uploadChequePage";

	}

	@RequestMapping(value = "openCam")
	public String takePhoto(Model model, HttpServletRequest request) {

		Webcam webcam = Webcam.getDefault();
		webcam.setViewSize(WebcamResolution.VGA.getSize());
		WebcamPanel panel = new WebcamPanel(webcam);
		JFrame window = new JFrame("Test webcam panel");
		window.add(panel);
		window.setResizable(true);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.pack();
		window.setVisible(true);
		return "takePhoto";

	}

	@RequestMapping(value = "takePhoto")
	public @ResponseBody String takephoto(Model model,
			HttpServletRequest request) {

		Webcam webcam = Webcam.getDefault();
		webcam.open();
		BufferedImage image = webcam.getImage();
		webcam.close();
		User user = (User) request.getSession().getAttribute("user");
		new File(
				"C:\\Users\\Kumaran\\OneDrive\\Web Tools\\Final_Project_Kumaran_Jayasankaran"
						+ "\\src\\main\\webapp\\resources\\uploads\\"
						+ user.getUserName()).mkdir();

		int randomName = (int) (Math.random() * 9999) + 1000;
		String newName = randomName + ".jpg";

		try {
			ImageIO.write(image, "JPG", new File(
					"C:\\Users\\Kumaran\\OneDrive\\Web Tools\\Final_Project_Kumaran_Jayasankaran"
							+ "\\src\\main\\webapp\\resources\\uploads\\"
							+ user.getUserName() + "\\" + randomName + ".jpg"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/* adding reference to DB */
		ChequeImage chequeImage = new ChequeImage();
		chequeImage.setFileName(newName);
		chequeImage.setUserName(user.getUserName());
		chequeImage.setUploadDate(new Date());
		userDao.addChequeToDB(chequeImage);
		return "success";
	}

	@RequestMapping(value = "contactsHome")
	public String contactshome(Model model) {
		return "contactsHome";

	}

	@RequestMapping(value = "addContact")
	public @ResponseBody String addContact(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String accountNumber = request.getParameter("accountNumber");
		String ifsc = request.getParameter("ifsc");

		Contacts contacts = new Contacts();
		contacts.setFirstName(firstName);
		contacts.setLastName(lastName);
		contacts.setEmail(email);
		contacts.setAccountNumber(Integer.parseInt(accountNumber));
		contacts.setIFSC(Integer.parseInt(ifsc));

		user.getContacts().add(contacts);

		int status = userDao.addContact(user, contacts);

		if (status == 1) {
			return "success";
		} else {
			return "failure";
		}

	}

	@RequestMapping(value = "viewContact")
	public String viewContact(Model model, HttpServletRequest request)
			throws Exception {

		User user = (User) request.getSession().getAttribute("user");

		User user2 = userDao.queryUserByNameAndPassword(user.getUserName(),
				user.getPassword());
		Set<Contacts> contacts = user2.getContacts();
		HttpSession session = request.getSession();
		session.setAttribute("user", user2);
		model.addAttribute("contacts", contacts);

		return "viewContacts";
	}

	@RequestMapping(value = "deleteContact", method = RequestMethod.POST)
	public String deleteContact(Model model, HttpServletRequest request) {

		int update = 0;
		User user = (User) request.getSession().getAttribute("user");
		String contactsID[] = request.getParameterValues("delete");

		if (contactsID == null) {
			model.addAttribute("contacts", user.getContacts());
			model.addAttribute("error", "No row(s) selected");
			return "viewContacts";

		}

		for (int i = 0; i < contactsID.length; i++) {
			int id = Integer.parseInt(contactsID[i]);
			try {
				update = userDao.deleteContact(id, user);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (update == 1) {
				continue;
			} else {
				break;
			}
		}

		User user2 = (User) userDao.queryUserByUserName(user.getUserName());
		if (update == 1) {
			model.addAttribute("contacts", user2.getContacts());
			return "viewContacts";
		}
		model.addAttribute("contacts", user2.getContacts());
		return "viewContacts";
	}

	@RequestMapping(value = "pendingCheques")
	public String pendingCheques(Model model) {

		List<ChequeImage> pendingCheques = tellerDao.getPendingChequeList();
		int size = pendingCheques.size();
		model.addAttribute("size", size);
		model.addAttribute("cheques", pendingCheques);
		return "pendingCheques";
	}

	@RequestMapping(value = "reviewCheque")
	public String reviewCheque(Model model, HttpServletRequest request) {

		int imageID = Integer.parseInt(request.getParameter("imageID"));
		ChequeImage cheque = tellerDao.queryChequeWithImageID(imageID);
		User user = userDao.queryUserByUserName(cheque.getUserName());
		String imagePath = "resources\\uploads\\" + cheque.getUserName() + "\\"
				+ cheque.getFileName();
		model.addAttribute("chequeUser", user);
		model.addAttribute("cheque", cheque);
		model.addAttribute("imagePath", imagePath);
		return "reviewCheque";
	}

	@RequestMapping(value = "approveCheque")
	public @ResponseBody String approveCheque(HttpServletRequest request) {

		int imageID = Integer.parseInt(request.getParameter("imageID"));
		tellerDao.approveCheque(imageID);
		return "success";
	}

	@RequestMapping(value = "rejectCheque")
	public @ResponseBody String rejectCheque(HttpServletRequest request) {

		int imageID = Integer.parseInt(request.getParameter("imageID"));
		tellerDao.rejectCheque(imageID);
		return "success";
	}

	@RequestMapping(value = "generatePDF")
	public void generatePDF(Model model, HttpServletRequest request,
			HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute("user");
		User u;
		try {
			u = userDao.queryUserByNameAndPassword(user.getUserName(),
					user.getPassword());
			List<MoneyTransaction> transactions = u.getMoneyTransactions();

			// Starting PDF part
			Document document = new Document();
			response.setContentType("application/pdf");
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();

			// Header header = new Header(new Phrase("Northeastern Bank"));
			document.addHeader("Header", "Northeastern Bank");

			document.add(new Paragraph("Name: " + user.getFirstName() + " "
					+ user.getLastName()));
			document.add(new Paragraph("Account Number: "
					+ user.getAccountNumber()));
			document.add(Chunk.NEWLINE);
			PdfPTable table = new PdfPTable(5);

			PdfPCell cell1 = new PdfPCell(new Paragraph("Date"));
			PdfPCell cell2 = new PdfPCell(new Paragraph("Description"));
			PdfPCell cell3 = new PdfPCell(new Paragraph("Type"));
			PdfPCell cell4 = new PdfPCell(new Paragraph("Amount"));
			PdfPCell cell5 = new PdfPCell(new Paragraph("Balance"));

			BaseColor color = WebColors.getRGBColor("#33ADD6");

			cell1.setBackgroundColor(color);
			cell2.setBackgroundColor(color);
			cell3.setBackgroundColor(color);
			cell4.setBackgroundColor(color);
			cell5.setBackgroundColor(color);

			table.addCell(cell1);
			table.addCell(cell2);
			table.addCell(cell3);
			table.addCell(cell4);
			table.addCell(cell5);

			for (MoneyTransaction tx : transactions) {
				table.addCell(String.valueOf(tx.getDate()));
				table.addCell(tx.getStatus());
				table.addCell(tx.getType());
				table.addCell(String.valueOf(tx.getAmount()));
				table.addCell(String.valueOf(tx.getBalance()));
			}
			document.add(table);
			document.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "forgotPassword")
	public String forgotPassword() {
		return "forgotPassword";
	}

	@RequestMapping(value = "forgotPasswordGetSQ")
	public @ResponseBody String forgotPasswordGetSQ(HttpServletRequest request) {

		String uname = request.getParameter("userName");
		User user = (User) userDao.queryUserByUserName(uname);

		if (user != null) {
			request.getSession().setAttribute("user", user);
			return user.getSecretQuestion();
		} else {
			return "fail";
		}

	}

	@RequestMapping(value = "retreivePassword")
	public @ResponseBody String retreivePassword(HttpServletRequest request) {

		String secretAnswer = request.getParameter("secretAnswer");
		int accountNumber = Integer.parseInt(request
				.getParameter("accountNumber"));

		User user = (User) request.getSession().getAttribute("user");

		if ((user.getSecretAnswer().equals(secretAnswer))
				&& (user.getAccountNumber() == accountNumber)) {
			userDao.sendPasswordMail(user);
			return "success";
		} else {
			return "fail";
		}

	}

	@RequestMapping(value = "editProfile")
	public String updateProfile(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		model.addAttribute("user", user);
		return "updateProfile";
	}
	
	@RequestMapping(value = "editTellerProfile")
	public String updateTellerProfile(Model model, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		model.addAttribute("user", user);
		return "editTellerProfile";
	}

	@RequestMapping(value = "changeAddress")
	public @ResponseBody String changeAddress(HttpServletRequest request) {

		String address = request.getParameter("address");
		User user = (User) request.getSession().getAttribute("user");

		user.setAddress(address);
		userDao.updateUser(user);
		return "success";
	}

	@RequestMapping(value = "changeEmail")
	public @ResponseBody String changeEmail(HttpServletRequest request) {

		String email = request.getParameter("email");
		User user = (User) request.getSession().getAttribute("user");

		String r = userDao.checkExistingEmail(email);

		if (r.equalsIgnoreCase("available")) {
			return "available";
		}

		user.setEmail(email);
		userDao.updateUser(user);
		return "success";
	}

	@RequestMapping(value = "changePhoneNumber")
	public @ResponseBody String changePhoneNumber(HttpServletRequest request) {

		long phoneNumber = Long.parseLong(request.getParameter("phoneNumber"));
		User user = (User) request.getSession().getAttribute("user");

		user.setPhoneNumber(phoneNumber);
		userDao.updateUser(user);
		return "success";
	}

	@RequestMapping(value = "changePassword")
	public @ResponseBody String changePassword(HttpServletRequest request) {

		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");

		User user = (User) request.getSession().getAttribute("user");

		if (oldPassword.equals(user.getPassword())) {

			user.setPassword(newPassword);
			userDao.updateUser(user);
			return "success";
		} else {
			return "fail";
		}
	}

	@RequestMapping(value = "logout")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession s = request.getSession();
		
		
		//s.invalidate(); 
		try {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("userNameCookie")) {
						cookies[i].setValue("");
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					} else if (cookies[i].getName()
							.equals("userPasswordCookie")) {
						cookies[i].setValue("");
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
				}
			}

			response.sendRedirect(request.getContextPath() + "/");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		s.removeAttribute("user");
		return "homePage";
	}

	@RequestMapping(value = "nearestBank")
	public String nearestBank() {
		return "nearestBank";
	}

	@RequestMapping(value = "showMap")
	public String showMap(Model model, @RequestParam("location") String location) {

		Geocoder geocoder = new Geocoder();
		GeocoderRequest geocoderRequest = new GeocoderRequestBuilder()
				.setAddress(location).setLanguage("en").getGeocoderRequest();
		GeocodeResponse geocoderResponse;
		try {
			geocoderResponse = geocoder.geocode(geocoderRequest);
			if (geocoderResponse.getStatus() == GeocoderStatus.OK
					& !geocoderResponse.getResults().isEmpty()) {
				GeocoderResult geocoderResult = geocoderResponse.getResults()
						.iterator().next();
				LatLng latitudeLongitude = geocoderResult.getGeometry()
						.getLocation();
				Double[] coords = new Double[2];
				coords[0] = latitudeLongitude.getLat().doubleValue();
				coords[1] = latitudeLongitude.getLng().doubleValue();
				model.addAttribute("lat", coords[0]);
				model.addAttribute("lng", coords[1]);

				return "showMap";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return "showMap";
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String submitForm(Model model,
			@RequestParam("address") String location, HttpServletRequest request) {
		if (location == null)
			return "home";
		Geocoder geocoder = new Geocoder();
		GeocoderRequest geocoderRequest = new GeocoderRequestBuilder()
				.setAddress(location) // location
				.setLanguage("en") // language
				.getGeocoderRequest();
		GeocodeResponse geocoderResponse;
		try {
			geocoderResponse = geocoder.geocode(geocoderRequest);
			if (geocoderResponse.getStatus() == GeocoderStatus.OK
					& !geocoderResponse.getResults().isEmpty()) {
				GeocoderResult geocoderResult = geocoderResponse.getResults()
						.iterator().next();
				LatLng latitudeLongitude = geocoderResult.getGeometry()
						.getLocation();
				Double[] coords = new Double[2];
				coords[0] = latitudeLongitude.getLat().doubleValue();
				coords[1] = latitudeLongitude.getLng().doubleValue();
				model.addAttribute("coords", coords);
				HttpSession session = request.getSession();
				session.setAttribute("coords", coords);
				return "location";
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "home";
	}
}
