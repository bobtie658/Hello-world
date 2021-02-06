import javafx.event.EventHandler;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.input.InputEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;

public class Cell {
    private final StackPane pane = new StackPane();
    private final TextField text = new TextField("0");
    private final Label operator = new Label();

    private final int rowNum;
    private final int number;


    public Cell(int number,int rowNum, EventHandler<InputEvent> mistake) {
        text.setMaxWidth(50);
        text.setAlignment(Pos.CENTER);
        Button decrease = new Button("-");
        decrease.setId("decrease");

        Button increase = new Button("+");
        increase.setMinSize(25,20);
        increase.setMaxSize(25,20);
        decrease.setMinSize(25,20);
        decrease.setMaxSize(25,20);

        text.textProperty().addListener((observable, oldValue, newValue) -> {
            if (!newValue.matches("\\d*")) {
                text.setText(newValue.replaceAll("[^\\d]", ""));
            }
        });

        increase.addEventHandler(MouseEvent.MOUSE_CLICKED,increaseClicked);
        increase.addEventHandler(InputEvent.ANY,mistake);
        decrease.addEventHandler(MouseEvent.MOUSE_CLICKED,decreaseClicked);
        decrease.addEventHandler(InputEvent.ANY,mistake);
        text.addEventHandler(InputEvent.ANY,mistake);

        VBox buttons = new VBox();
        buttons.getChildren().addAll(increase, decrease);
        buttons.setAlignment(Pos.CENTER_RIGHT);

        HBox input = new HBox();
        input.getChildren().addAll(text, buttons);
        input.setAlignment(Pos.CENTER);

        pane.getChildren().setAll(input,operator);
        StackPane.setAlignment(operator, Pos.TOP_LEFT);
        pane.setMinSize(50,50);
        pane.setMaxSize(Double.POSITIVE_INFINITY,Double.POSITIVE_INFINITY);

        this.number = number;
        pane.getStyleClass().add("StackPane");
        this.rowNum = rowNum;
    }

    protected void setOperator(String string) {
        operator.setText(string);
    }

    protected void setText(int number) {
        text.setText(Integer.toString(number));
    }

    protected String getText() {
        return text.getText();
    }

    protected Label getOperator() {
        return operator;
    }

    protected TextField getTextField() {
        return text;
    }

    protected int getNumber() {
        return number;
    }

    protected StackPane getCell() {
        return pane;
    }

    EventHandler<MouseEvent> increaseClicked = new EventHandler<>() {
        public void handle(MouseEvent mouseEvent) {
            if (getText() == null) {
                setText(0);
            }

            if (Integer.parseInt(getText()) < rowNum)
                setText((Integer.parseInt(getText()) + 1));
        }
    };

    EventHandler<MouseEvent> decreaseClicked = mouseEvent -> {
        if(getText()==null){
            setText(0);
        }

        if (Integer.parseInt(getText()) > 0) {
            setText((Integer.parseInt(getText()) - 1));
        }
    };
}
