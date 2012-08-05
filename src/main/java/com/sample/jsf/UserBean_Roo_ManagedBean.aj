// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.sample.jsf;

import com.sample.domain.User;
import com.sample.jsf.UserBean;
import com.sample.service.StorageService;
import com.sample.service.UserService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.el.ELContext;
import javax.el.ExpressionFactory;
import javax.el.MethodExpression;
import javax.el.ValueExpression;
import javax.faces.application.Application;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.component.html.HtmlOutputText;
import javax.faces.component.html.HtmlPanelGrid;
import javax.faces.context.FacesContext;
import javax.faces.validator.RegexValidator;
import javax.faces.validator.RequiredValidator;

import org.primefaces.component.fileupload.FileUpload;
import org.primefaces.component.graphicimage.GraphicImage;
import org.primefaces.component.inputtext.InputText;
import org.primefaces.component.message.Message;
import org.primefaces.context.RequestContext;
import org.primefaces.event.CloseEvent;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;
import org.springframework.beans.factory.annotation.Autowired;

privileged aspect UserBean_Roo_ManagedBean {

    declare @type: UserBean:@ManagedBean(name = "userBean");

    declare @type: UserBean:@SessionScoped;

    @Autowired
    UserService UserBean.userService;

    @Autowired
    StorageService UserBean.storageService;

    private String UserBean.name = "Users";

    private User UserBean.user;

    private List<User> UserBean.allUsers;

    private boolean UserBean.dataVisible = false;

    private List<String> UserBean.columns;

    private HtmlPanelGrid UserBean.createPanelGrid;

    private HtmlPanelGrid UserBean.editPanelGrid;

    private HtmlPanelGrid UserBean.viewPanelGrid;

    private boolean UserBean.createDialogVisible = false;

    @PostConstruct
    public void UserBean.init() {
        columns = new ArrayList<String>();
        columns.add("password");
        columns.add("name");
        columns.add("email");
    }

    public String UserBean.getName() {
        return name;
    }

    public List<String> UserBean.getColumns() {
        return columns;
    }

    public List<User> UserBean.getAllUsers() {
        return allUsers;
    }

    public void UserBean.setAllUsers(List<User> allUsers) {
        this.allUsers = allUsers;
    }

    public String UserBean.findAllUsers() {
        allUsers = userService.findAllUsers();
        dataVisible = !allUsers.isEmpty();
        return null;
    }

    public boolean UserBean.isDataVisible() {
        return dataVisible;
    }

    public void UserBean.setDataVisible(boolean dataVisible) {
        this.dataVisible = dataVisible;
    }

    public HtmlPanelGrid UserBean.getCreatePanelGrid() {
        if (createPanelGrid == null) {
            createPanelGrid = populateCreatePanel();
        }
        return createPanelGrid;
    }

    public void UserBean.setCreatePanelGrid(HtmlPanelGrid createPanelGrid) {
        this.createPanelGrid = createPanelGrid;
    }

    public HtmlPanelGrid UserBean.getEditPanelGrid() {
        if (editPanelGrid == null) {
            editPanelGrid = populateEditPanel();
        }
        return editPanelGrid;
    }

    public void UserBean.setEditPanelGrid(HtmlPanelGrid editPanelGrid) {
        this.editPanelGrid = editPanelGrid;
    }

    public HtmlPanelGrid UserBean.getViewPanelGrid() {
        return populateViewPanel();
    }

    public void UserBean.setViewPanelGrid(HtmlPanelGrid viewPanelGrid) {
        this.viewPanelGrid = viewPanelGrid;
    }

    public void UserBean.handleFileUpload(FileUploadEvent event) {
        try {
            String imageId = storageService.save(event.getFile().getInputstream(), "image/png", event.getFile().getFileName());
            user.setImageFileId(imageId);
            FacesMessage msg = new FacesMessage(event.getFile().getFileName() + " is uploaded.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public HtmlPanelGrid UserBean.populateCreatePanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();

        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);

        HtmlOutputText passwordCreateOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        passwordCreateOutput.setId("passwordCreateOutput");
        passwordCreateOutput.setValue("Password: * ");
        htmlPanelGrid.getChildren().add(passwordCreateOutput);

        InputText passwordCreateInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        passwordCreateInput.setId("passwordCreateInput");
        passwordCreateInput.addValidator(new RequiredValidator());
        passwordCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.password}", String.class));
        htmlPanelGrid.getChildren().add(passwordCreateInput);

        Message passwordCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        passwordCreateInputMessage.setId("passwordCreateInputMessage");
        passwordCreateInputMessage.setFor("passwordCreateInput");
        passwordCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(passwordCreateInputMessage);

        HtmlOutputText nameCreateOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        nameCreateOutput.setId("nameCreateOutput");
        nameCreateOutput.setValue("Name: * ");
        htmlPanelGrid.getChildren().add(nameCreateOutput);

        InputText nameCreateInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        nameCreateInput.setId("nameCreateInput");
        nameCreateInput.addValidator(new RequiredValidator());
        nameCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.name}", String.class));
        htmlPanelGrid.getChildren().add(nameCreateInput);

        Message nameCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        nameCreateInputMessage.setId("nameCreateInputMessage");
        nameCreateInputMessage.setFor("nameCreateInput");
        nameCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(nameCreateInputMessage);

        HtmlOutputText emailCreateOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        emailCreateOutput.setId("emailCreateOutput");
        emailCreateOutput.setValue("Email:   ");
        htmlPanelGrid.getChildren().add(emailCreateOutput);

        InputText emailCreateInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        emailCreateInput.setId("emailCreateInput");
        emailCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.email}", String.class));
        RegexValidator emailCreateInputRegexValidator = new RegexValidator();
        emailCreateInputRegexValidator.setPattern("[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z0-9]+");
        emailCreateInput.addValidator(emailCreateInputRegexValidator);
        htmlPanelGrid.getChildren().add(emailCreateInput);

        Message emailCreateInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        emailCreateInputMessage.setId("emailCreateInputMessage");
        emailCreateInputMessage.setFor("emailCreateInput");
        emailCreateInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(emailCreateInputMessage);

        HtmlOutputText fileUploadFieldOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        fileUploadFieldOutput.setId("fileUploadFieldOutput");
        fileUploadFieldOutput.setValue("Image: * ");
        htmlPanelGrid.getChildren().add(fileUploadFieldOutput);

        FileUpload fileUploadField = (FileUpload) application.createComponent(FileUpload.COMPONENT_TYPE);
        fileUploadField.setId("fileUploadField");
        fileUploadField.setMode("advanced");
        fileUploadField.setAllowTypes("/(\\.|\\/)(png)$/");
        fileUploadField.setAuto(true);
        fileUploadField.addValidator(new RequiredValidator());

        Class[] classList = new Class[1];
        classList[0] = FileUploadEvent.class;
        MethodExpression me = expressionFactory.createMethodExpression(elContext,
                "#{userBean.handleFileUpload}",
                void.class, classList);
        ValueExpression uploaded = expressionFactory.createValueExpression(elContext,
                "#{userBean.imageFile}",
                FileUploadEvent.class);
        fileUploadField.setFileUploadListener(me);
        // fileUploadField.setValueExpression("value", uploaded);
        // nameCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.name}", String.class));
        htmlPanelGrid.getChildren().add(fileUploadField);

        Message fileUploadMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        fileUploadMessage.setId("fileUploadMessage");
        fileUploadMessage.setFor("fileUploadField");
        fileUploadMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(fileUploadMessage);


        return htmlPanelGrid;
    }

    public HtmlPanelGrid UserBean.populateEditPanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();

        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);

        HtmlOutputText passwordEditOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        passwordEditOutput.setId("passwordEditOutput");
        passwordEditOutput.setValue("Password: * ");
        htmlPanelGrid.getChildren().add(passwordEditOutput);

        InputText passwordEditInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        passwordEditInput.setId("passwordEditInput");
        passwordEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.password}", String.class));
        htmlPanelGrid.getChildren().add(passwordEditInput);

        Message passwordEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        passwordEditInputMessage.setId("passwordEditInputMessage");
        passwordEditInputMessage.setFor("passwordEditInput");
        passwordEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(passwordEditInputMessage);

        HtmlOutputText nameEditOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        nameEditOutput.setId("nameEditOutput");
        nameEditOutput.setValue("Name: * ");
        htmlPanelGrid.getChildren().add(nameEditOutput);

        InputText nameEditInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        nameEditInput.setId("nameEditInput");
        nameEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.name}", String.class));
        htmlPanelGrid.getChildren().add(nameEditInput);

        Message nameEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        nameEditInputMessage.setId("nameEditInputMessage");
        nameEditInputMessage.setFor("nameEditInput");
        nameEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(nameEditInputMessage);

        HtmlOutputText emailEditOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        emailEditOutput.setId("emailEditOutput");
        emailEditOutput.setValue("Email:   ");
        htmlPanelGrid.getChildren().add(emailEditOutput);

        InputText emailEditInput = (InputText) application.createComponent(InputText.COMPONENT_TYPE);
        emailEditInput.setId("emailEditInput");
        emailEditInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.email}", String.class));
        RegexValidator emailEditInputRegexValidator = new RegexValidator();
        emailEditInputRegexValidator.setPattern("[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z0-9]+");
        emailEditInput.addValidator(emailEditInputRegexValidator);
        htmlPanelGrid.getChildren().add(emailEditInput);

        Message emailEditInputMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        emailEditInputMessage.setId("emailEditInputMessage");
        emailEditInputMessage.setFor("emailEditInput");
        emailEditInputMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(emailEditInputMessage);

        HtmlOutputText fileUploadFieldOutput = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        fileUploadFieldOutput.setId("fileUploadFieldOutput");
        fileUploadFieldOutput.setValue("Image: * ");
        htmlPanelGrid.getChildren().add(fileUploadFieldOutput);

        FileUpload fileUploadField = (FileUpload) application.createComponent(FileUpload.COMPONENT_TYPE);
        fileUploadField.setId("fileUploadField");
        fileUploadField.setMode("advanced");
        fileUploadField.setAllowTypes("/(\\.|\\/)(png)$/");
        fileUploadField.setAuto(true);
        fileUploadField.addValidator(new RequiredValidator());

        Class[] classList = new Class[1];
        classList[0] = FileUploadEvent.class;
        MethodExpression me = expressionFactory.createMethodExpression(elContext,
                "#{userBean.handleFileUpload}",
                void.class, classList);
        ValueExpression uploaded = expressionFactory.createValueExpression(elContext,
                "#{userBean.imageFile}",
                FileUploadEvent.class);
        fileUploadField.setFileUploadListener(me);
        // fileUploadField.setValueExpression("value", uploaded);
        // nameCreateInput.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.name}", String.class));
        htmlPanelGrid.getChildren().add(fileUploadField);

        Message fileUploadMessage = (Message) application.createComponent(Message.COMPONENT_TYPE);
        fileUploadMessage.setId("fileUploadMessage");
        fileUploadMessage.setFor("fileUploadField");
        fileUploadMessage.setDisplay("icon");
        htmlPanelGrid.getChildren().add(fileUploadMessage);

        return htmlPanelGrid;
    }

    public HtmlPanelGrid UserBean.populateViewPanel() {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        Application application = facesContext.getApplication();
        ExpressionFactory expressionFactory = application.getExpressionFactory();
        ELContext elContext = facesContext.getELContext();

        HtmlPanelGrid htmlPanelGrid = (HtmlPanelGrid) application.createComponent(HtmlPanelGrid.COMPONENT_TYPE);

        HtmlOutputText passwordLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        passwordLabel.setId("passwordLabel");
        passwordLabel.setValue("Password:   ");
        htmlPanelGrid.getChildren().add(passwordLabel);

        HtmlOutputText passwordValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        passwordValue.setId("passwordValue");
        passwordValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.password}", String.class));
        htmlPanelGrid.getChildren().add(passwordValue);

        HtmlOutputText nameLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        nameLabel.setId("nameLabel");
        nameLabel.setValue("Name:   ");
        htmlPanelGrid.getChildren().add(nameLabel);

        HtmlOutputText nameValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        nameValue.setId("nameValue");
        nameValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.name}", String.class));
        htmlPanelGrid.getChildren().add(nameValue);

        HtmlOutputText emailLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        emailLabel.setId("emailLabel");
        emailLabel.setValue("Email:   ");
        htmlPanelGrid.getChildren().add(emailLabel);

        HtmlOutputText emailValue = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        emailValue.setId("emailValue");
        emailValue.setValueExpression("value", expressionFactory.createValueExpression(elContext, "#{userBean.user.email}", String.class));
        htmlPanelGrid.getChildren().add(emailValue);

        HtmlOutputText imageLabel = (HtmlOutputText) application.createComponent(HtmlOutputText.COMPONENT_TYPE);
        imageLabel.setId("imageValue");
        imageLabel.setValue("Image: * ");
        htmlPanelGrid.getChildren().add(imageLabel);

        GraphicImage imageValue = (GraphicImage) application.createComponent(GraphicImage.COMPONENT_TYPE);
        imageValue.setAlt("user image");
        imageValue.setHeight("80");
        imageValue.setWidth("60");
        ValueExpression uploaded = expressionFactory.createValueExpression(elContext,
                "../image/#{userBean.user.imageFileId}.png",
                String.class);
        imageValue.setValueExpression("value",uploaded);
        htmlPanelGrid.getChildren().add(imageValue);

        FileUpload fileUploadField = (FileUpload) application.createComponent(FileUpload.COMPONENT_TYPE);
        fileUploadField.setId("fileUploadField");
        fileUploadField.setMode("advanced");
        fileUploadField.setAuto(true);

        return htmlPanelGrid;
    }

    public User UserBean.getUser() {
        if (user == null) {
            user = new User();
        }
        return user;
    }

    public void UserBean.setUser(User user) {
        this.user = user;
    }

    public String UserBean.onEdit() {
        return null;
    }

    public boolean UserBean.isCreateDialogVisible() {
        return createDialogVisible;
    }

    public void UserBean.setCreateDialogVisible(boolean createDialogVisible) {
        this.createDialogVisible = createDialogVisible;
    }

    public String UserBean.displayList() {
        createDialogVisible = false;
        findAllUsers();
        return "user";
    }

    public String UserBean.displayCreateDialog() {
        user = new User();
        createDialogVisible = true;
        return "user";
    }

    public String UserBean.persist() {
        String message = "";
        if (user.getId() != null) {
            userService.updateUser(user);
            message = "Successfully updated";
        } else {
            userService.saveUser(user);
            message = "Successfully created";
        }
        RequestContext context = RequestContext.getCurrentInstance();
        context.execute("createDialog.hide()");
        context.execute("editDialog.hide()");

        FacesMessage facesMessage = new FacesMessage(message);
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllUsers();
    }

    public String UserBean.delete() {
        userService.deleteUser(user);
        FacesMessage facesMessage = new FacesMessage("Successfully deleted");
        FacesContext.getCurrentInstance().addMessage(null, facesMessage);
        reset();
        return findAllUsers();
    }

    public void UserBean.reset() {
        user = null;
        createDialogVisible = false;
    }

    public void UserBean.handleDialogClose(CloseEvent event) {
        reset();
    }

}
