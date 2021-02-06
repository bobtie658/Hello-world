import javafx.event.EventHandler;
import javafx.scene.input.InputEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Priority;

import java.util.ArrayList;

public class Grid {
    private final ArrayList<Cell> cells = new ArrayList<>();
    private final ArrayList<Group> groups = new ArrayList<>();

    protected void addToGrid(int cellNum, EventHandler<InputEvent> mistake){
        for(int i=0;i<cellNum;i++) {
            cells.add(new Cell(i, (int)Math.sqrt(cellNum), mistake));
        }
    }

    protected ArrayList<Cell> getCells() {
        return cells;
    }

    protected Cell getCell(int position) {
        return cells.get(position-1);
    }

    protected ArrayList<Group> getGroup() {
        return groups;
    }

    protected void addToPane(GridPane gridPane) {
        for(Cell cell : cells) {
            int index=cells.indexOf(cell);
            int columnNo = (int)(index%Math.sqrt(cells.size()));
            int rowNo = (int)Math.floor((index/Math.sqrt(cells.size())));
            gridPane.add(cell.getCell(), columnNo, rowNo);
            GridPane.setHgrow(cell.getCell(), Priority.ALWAYS);
            GridPane.setVgrow(cell.getCell(),Priority.ALWAYS);
        }
    }

    protected void addGroup(int[] cellsToAdd, String operator) {
        ArrayList<Cell> groupCells = new ArrayList<>();
        for(int i : cellsToAdd){
            groupCells.add(getCell(i));
        }
        groups.add(new Group(groupCells,operator,(int)Math.sqrt(cells.size())));
    }
}
