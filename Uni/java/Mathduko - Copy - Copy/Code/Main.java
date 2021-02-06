import javafx.animation.FadeTransition;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.InputEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.*;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.util.Duration;
import java.io.File;
import java.util.*;

public class Main extends Application {

    private int numCells = 36;
    private int rowNum = (int)Math.sqrt(numCells);
    private boolean won = false;
    private final Stack<ArrayList<String>> undoStack = new Stack<>();
    private final Stack<ArrayList<String>> redoStack = new Stack<>();
    private boolean firstUndo = false;

    private final Image undoImg = new Image("/images/undo.png");
    private final Image redoImg = new Image("/images/redo.png");
    private final Image clearImg = new Image("/images/clear.png");
    private final Image uploadImg = new Image("/images/upload.png");
    private final Image textImg = new Image("/images/text.png");
    private final Image icon = new Image("/images/icon.png");

    private final Button undo = new Button("",new ImageView(undoImg));
    private final Button redo = new Button("",new ImageView(redoImg));
    private final Button clear = new Button("",new ImageView(clearImg));
    private final Button loadF = new Button("",new ImageView(uploadImg));
    private final Button loadT = new Button("",new ImageView(textImg));
    private final CheckBox mistakes = new CheckBox("Show mistakes");
    private final Slider textSize = new Slider(1,3,2);
    private final Label textSizeLabel = new Label("change text size");

    private final Tooltip undoTip = new Tooltip("undo");
    private final Tooltip redoTip = new Tooltip("redo");
    private final Tooltip clearTip = new Tooltip("clear");
    private final Tooltip uploadTip = new Tooltip("upload file");
    private final Tooltip textTip = new Tooltip("text input");

    private final BorderPane pane = new BorderPane();
    private final GridPane gridPane = new GridPane();
    private final HBox tools = new HBox();
    private final HBox edit = new HBox();
    private final HBox upload = new HBox();
    private Grid grid = new Grid();
    private final VBox changeTextSize = new VBox();

    private final FadeTransition gridOut = new FadeTransition(Duration.seconds(1), gridPane);
    private final FadeTransition gridIn = new FadeTransition((Duration.seconds(2)),gridPane);

    private final FileChooser fileChooser = new FileChooser();
    private final Dialog<String> textDialog = new Dialog<>();
    private final Alert loadError = new Alert(Alert.AlertType.ERROR);

    public void start(Stage stage) {
        grid.addToGrid(numCells,checkMistakes);
        gridPane.setMinSize(100,100);
        pane.setCenter(gridPane);
        pane.setBottom(tools);
        stage.getIcons().add(icon);

        fileChooser.setTitle("Select config file");
        fileChooser.getExtensionFilters().add(new FileChooser.ExtensionFilter("text files (*.txt)","*.txt"));

        textDialog.setTitle("Text input");
        textDialog.setHeaderText("Please input custom grid source");
        textDialog.getDialogPane().getButtonTypes().addAll(ButtonType.OK,ButtonType.CANCEL);
        GridPane dialogContent = new GridPane();
        TextArea dialogText = new TextArea();
        dialogContent.getChildren().add(dialogText);
        textDialog.getDialogPane().setContent(dialogContent);
        textDialog.setResultConverter(dialogButton -> {
            if(dialogButton == ButtonType.OK) {
                return dialogText.getText();
            }
            return null;
        });

        loadError.setTitle("error");
        loadError.setHeaderText("error");
        loadError.setContentText("An error occurred while attempting to load custom grid, please try again");

        EventHandler<ActionEvent> loadFile = actionEvent -> {
            File file = fileChooser.showOpenDialog(stage);

            if(file!=null && !loadFile(file)){
                loadError.showAndWait();
            }
        };

        EventHandler<ActionEvent> loadText = actionEvent -> {
            Optional<String> result = textDialog.showAndWait();

            if(result.isPresent() && !result.get().isEmpty()){
                if(!load(result.get())) {
                    loadError.showAndWait();
                }
            }
        };

        gridOut.setFromValue(1);
        gridIn.setFromValue(0);
        gridOut.setToValue(0);
        gridIn.setToValue(1);
        gridOut.setAutoReverse(false);
        gridIn.setAutoReverse(false);
        gridOut.setCycleCount(1);
        gridIn.setCycleCount(1);

        startGrid();

        textSize.setSnapToTicks(true);
        textSize.setMajorTickUnit(1);
        textSize.setMinorTickCount(0);
        textSize.addEventHandler(MouseEvent.MOUSE_CLICKED,sizeChange);
        textSizeLabel.setId("textMedium");
        mistakes.setId("textMedium");

        undo.setTooltip(undoTip);
        redo.setTooltip(redoTip);
        clear.setTooltip(clearTip);
        loadF.setTooltip(uploadTip);
        loadT.setTooltip(textTip);

        undo.getStyleClass().add("nodes");
        redo.getStyleClass().add("nodes");
        clear.getStyleClass().add("nodes");
        loadF.getStyleClass().add("nodes");
        loadT.getStyleClass().add("nodes");
        mistakes.getStyleClass().add("nodes");

        mistakes.addEventHandler(InputEvent.ANY,checkMistakes);
        clear.setOnAction(clearCells);
        loadF.setOnAction(loadFile);
        loadT.setOnAction(loadText);
        undo.addEventHandler(MouseEvent.MOUSE_CLICKED,undoEvent);
        redo.addEventHandler(MouseEvent.MOUSE_CLICKED,redoEvent);

        edit.getChildren().addAll(undo,redo,clear);
        upload.getChildren().addAll(loadF,loadT);

        changeTextSize.getChildren().addAll(textSize,textSizeLabel);
        changeTextSize.setAlignment(Pos.CENTER);

        tools.getChildren().addAll(edit,upload,mistakes,changeTextSize);
        HBox.setHgrow(edit, Priority.ALWAYS);
        HBox.setHgrow(upload, Priority.ALWAYS);
        HBox.setHgrow(mistakes, Priority.ALWAYS);
        tools.setSpacing(30);
        tools.setAlignment(Pos.CENTER);
        tools.setId("bottom");

        Scene scene = new Scene(pane);
        scene.getStylesheets().add("Style.css");
        stage.setScene(scene);
        stage.setMinWidth(710);
        stage.setMinHeight(650);
        stage.setTitle("Mathduko");
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }

    private boolean testCorrect(){
        resetColour();
        boolean groupCheck = true;

        for(Group group : grid.getGroup()) {
            if(!group.checkSuccess()){
                groupCheck = false;
            }
        }

        boolean colCheck = checkColCorrect();
        boolean rowCheck = checkRowCorrect();

        if(!mistakes.isSelected()){
            resetColour();
        }

        return groupCheck & colCheck & rowCheck;
    }

    private boolean checkRowCorrect() {
        ArrayList<Integer> base = new ArrayList<>();
        ArrayList<Cell> cells = grid.getCells();
        boolean result = true;

        for(int j=1;j<=rowNum;j++) {
            base.add(j);
        }

        for(int i=0;i<rowNum;i++) {
            ArrayList<Integer> colCells = new ArrayList<>();
            ArrayList<Cell> toColour = new ArrayList<>();

            for(Cell cell : cells) {
                if(cell.getText().isEmpty()){
                    return false;
                }
                if(Math.floor((double)cell.getNumber()/(double)rowNum) == i) {
                    colCells.add(Integer.parseInt(cell.getText()));
                    toColour.add(cell);
                }
            }

            for(Cell cell : toColour){
                if(!arrayEqual(colCells, base)) {
                    if(cell.getCell().getId().equals("wrongColumn")){
                        cell.getCell().setId("wrongBoth");
                    }else {
                        cell.getCell().setId("wrongRow");
                    }
                    result = false;
                }
            }
        }
        return result;
    }

    private boolean checkColCorrect() {
        ArrayList<Integer> base = new ArrayList<>();
        ArrayList<Cell> cells = grid.getCells();
        boolean result = true;

        for(int j=1;j<=rowNum;j++) {
            base.add(j);
        }

        for(int i=0;i<rowNum;i++) {
            ArrayList<Integer> colCells = new ArrayList<>();
            ArrayList<Cell> toColour = new ArrayList<>();

            for(Cell cell : cells) {
                if(cell.getText().isEmpty()){
                    return false;
                }
                if((cell.getNumber()%rowNum) == i) {
                    colCells.add(Integer.parseInt(cell.getText()));
                    toColour.add(cell);
                }
            }

            for(Cell cell : toColour){
                if(!arrayEqual(colCells, base)) {
                    cell.getCell().setId("wrongColumn");
                    result = false;
                }
            }
        }
        return result;
    }

    private void resetColour(){
        for(Cell cell : grid.getCells()){
            cell.getCell().setId("emptyId");
        }
    }

    public boolean arrayEqual(ArrayList<Integer> a1, ArrayList<Integer> a2) {
        if(!(a1.size() == a2.size())) {
            return false;
        }
        Collections.sort(a1);
        Collections.sort(a2);

        for(int i=0; i<a1.size(); i++) {
            if(!(a1.get(i).equals(a2.get(i)))){
                return false;
            }
        }
        return true;
    }

    private void checkWin() {
        boolean win = testCorrect();

        if(win&&!won){
            won=true;
            gridOut.play();
            gridPane.getChildren();
            gridPane.getChildren().clear();
            gridPane.setId("fireworks");
            System.out.println("You win!");
            gridIn.play();
            return;
        }

        addToUndo();
    }

    private boolean load(String string) {
        try{
            String[] lines = string.split("\n");
            ArrayList<Integer> cells = new ArrayList<>();

            for(String line : lines) {
                if(line.split(" ").length!=2) {
                    return false;
                }
                String[] cellArray = line.split(" ")[1].split(",");
                for(String cell : cellArray) {
                    cells.add(Integer.parseInt(cell));
                }
            }

            Collections.sort(cells);
            int cellNum = cells.get(cells.size()-1);
            int rowNum = (int)Math.sqrt(cellNum);
            if (Math.sqrt(cellNum)!=(double)rowNum) {
                return false;
            }
            Grid newGrid = new Grid();
            newGrid.addToGrid(cellNum,checkMistakes);

            if(rowNum>8) {
                return false;
            }

            for(String line : lines) {
                String[] cellArray = line.split(" ")[1].split(",");
                int[] cellNums = new int[cellArray.length];
                for(int i=0; i<cellArray.length; i++){
                    cellNums[i] = Integer.parseInt(cellArray[i]);
                }
                String operator = line.split(" ")[0];
                newGrid.addGroup(cellNums,operator);
            }

            grid.getCells().clear();
            grid.getGroup().clear();
            gridPane.getChildren().clear();
            grid = newGrid;
            numCells = cellNum;
            this.rowNum = rowNum;
            grid.addToPane(gridPane);
            updateSize();
            testCorrect();
            won=false;
            undoStack.clear();
            addToUndo();
            redoStack.clear();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean loadFile(File file) {
        try {
            Scanner scanner = new Scanner(file,"UTF-8");
            String output = "";
            while(scanner.hasNextLine()) {
                output += scanner.nextLine() + "\n";
            }
            scanner.close();
            output = output.substring(0,output.length()-1);

            return load(output);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private void startGrid() {
        grid.addToPane(gridPane);
        grid.addGroup(new int[]{1, 7},"11+");
        grid.addGroup(new int[]{2, 3},"2÷");
        grid.addGroup(new int[]{4, 10},"20x");
        grid.addGroup(new int[]{5, 6,12,18},"6x");
        grid.addGroup(new int[]{8, 9},"3-");
        grid.addGroup(new int[]{11, 17},"3÷");
        grid.addGroup(new int[]{13, 14,19,20},"240x");
        grid.addGroup(new int[]{15, 16},"6x");
        grid.addGroup(new int[]{21, 27},"6x");
        grid.addGroup(new int[]{22,28,29},"7+");
        grid.addGroup(new int[]{23, 24},"30x");
        grid.addGroup(new int[]{26, 25},"6x");
        grid.addGroup(new int[]{30, 36},"9+");
        grid.addGroup(new int[]{31,32,33},"8+");
        grid.addGroup(new int[]{34,35},"2÷");
        undoStack.push(copyCells());
    }

    private void updateSize() {
        int sliderPoint = (int)textSize.getValue();
        String styleId = "emptyId";
        if (sliderPoint == 1) {
            styleId = "textSmall";
        } else if (sliderPoint == 2) {
            styleId = "textMedium";
        } else if (sliderPoint == 3) {
            styleId = "textLarge";
        }

        mistakes.setId(styleId);
        textSizeLabel.setId(styleId);
        for (Cell cell : grid.getCells()){
            cell.getOperator().setId(styleId);
            cell.getTextField().setId(styleId);
        }
    }

    private ArrayList<String> copyCells() {
        ArrayList<String> newCells = new ArrayList<>();
        for (Cell cell : grid.getCells()){
            newCells.add(cell.getText());
        }
        return newCells;
    }

    private void addToUndo() {
        if (undoStack.empty()){
            undoStack.push(new ArrayList<>(copyCells()));
            return;
        }

        ArrayList<String> top = undoStack.peek();
        ArrayList<String> newCells = copyCells();
        if (!top.equals(newCells)) {
            redoStack.clear();
            undoStack.push(newCells);
            firstUndo=true;
        }
    }

    private void undoMethod() {
        if (undoStack.empty()){
            return;
        }


        if (firstUndo){
            undoStack.pop();
            firstUndo=false;
        }

        redoStack.push(new ArrayList<>(copyCells()));
        ArrayList<String> newCells = undoStack.pop();
        for (int i=0; i<newCells.size(); i++) {
            grid.getCells().get(i).setText(Integer.parseInt(newCells.get(i)));
        }
        testCorrect();
    }

    private void redoMethod() {
        if (redoStack.empty()){
            return;
        }
        undoStack.push(new ArrayList<>(copyCells()));

        ArrayList<String> newCells = redoStack.pop();
        for (int i=0; i<newCells.size(); i++) {
            grid.getCells().get(i).setText(Integer.parseInt(newCells.get(i)));
        }
        testCorrect();
    }

    EventHandler<InputEvent> checkMistakes = inputEvent -> checkWin();

    EventHandler<ActionEvent> clearCells = actionEvent -> {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION, "Clear grid?", ButtonType.YES, ButtonType.NO);
        alert.setHeaderText(null);
        alert.showAndWait();

        if (alert.getResult() == ButtonType.YES) {
            for (Cell cell : grid.getCells()) {
                cell.setText(0);
            }
            checkWin();
        }
    };

    EventHandler<MouseEvent> sizeChange = MouseEvent -> updateSize();

    EventHandler<MouseEvent> undoEvent = MouseEvent -> undoMethod();

    EventHandler<MouseEvent> redoEvent = MouseEvent -> redoMethod();
}
