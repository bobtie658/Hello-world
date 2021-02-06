import javafx.application.Application;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.ButtonType;
import javafx.scene.control.TextInputDialog;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;

public class Walter extends Application {
    public void start(Stage stage) {
        TextInputDialog dialog = new TextInputDialog("Walter");
        dialog.setTitle("Walter");
        dialog.setHeaderText("Walter");
        dialog.setContentText("Please enter walter:");
        dialog.setGraphic(new ImageView(new Image("file:Walter/Walter.png",72,90.,true,true)));
        Stage s = (Stage) dialog.getDialogPane().getScene().getWindow();
        s.getIcons().add(new Image("file:Walter/Walter.png",36,45,true,true));
        dialog.getDialogPane().getButtonTypes().clear();
        ButtonType walterButton = new ButtonType("Walter", ButtonBar.ButtonData.OK_DONE);
        dialog.getDialogPane().getButtonTypes().add(walterButton);
        dialog.showAndWait();
    }

    public static void main(String[] args){
        launch(args);
    }
}
