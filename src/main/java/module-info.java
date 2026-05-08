module it.polimi.agenzia {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.controlsfx.controls;

    opens it.polimi.agenzia to javafx.fxml;
    exports it.polimi.agenzia;
}