import java.util.ArrayList;
import java.util.Collections;

public class Group {
    private final ArrayList<Cell> cells;
    private final String operator;

    protected Group(ArrayList<Cell> cells, String operator, int rowNum) {
        this.cells = cells;
        this.operator = operator;
        Cell smallest = cells.get(0);

        for(Cell x : cells) {
            if (x.getNumber() < smallest.getNumber()) {
                smallest = x;
            }
        }

        smallest.setOperator(operator);
        checkBorders(rowNum);
    }

    private ArrayList<Cell> getCells() {
        return cells;
    }

    private ArrayList<Integer> getTexts() {
        ArrayList<Integer> labels = new ArrayList<>();

        for(Cell cell : cells) {
            labels.add(Integer.parseInt(cell.getText()));
        }
        Collections.sort(labels);
        return labels;
    }

    protected boolean checkSuccess() {
        char operatorLast = operator.charAt(operator.length()-1);
        String isOperatorNum = operator.substring(0, operator.length() - 1);
        for(Cell cell : getCells()){
            if(cell.getText().isEmpty()){
                return false;
            }
        }

        if(!isOperatorNum.equals("")) {
            int operatorNum = Integer.parseInt(isOperatorNum);

            if (operatorLast == '+') {
                int sum = 0;
                for (Integer i : getTexts()) {
                    sum += i;
                }
                if (sum == operatorNum) {
                    return true;
                } else {
                    colourCells();
                    return false;
                }

            } else if (operatorLast == 'x') {
                int product = 1;
                for (Integer i : getTexts()) {
                    product = product * i;
                }
                if (product == operatorNum) {
                    return true;
                } else {
                    colourCells();
                    return false;
                }

            } else if (operatorLast == '-') {
                if (getTexts().size() == 2 && getTexts().get(1) - getTexts().get(0) == operatorNum) {
                    return true;
                } else if (getTexts().size() == 3 && getTexts().get(2) - getTexts().get(1) - getTexts().get(0) == operatorNum) {
                    return true;
                } else {
                    colourCells();
                    return false;
                }

            } else if (operatorLast == '÷') {
                if (getTexts().size() == 2 && (double) operatorNum == (double) (getTexts().get(1)) / (double) (getTexts().get(0))) {
                    return true;
                } else if (getTexts().size() == 3 && (double) operatorNum == (double) (getTexts().get(2)) / (double) (getTexts().get(1)) / (double) (getTexts().get(0))) {
                    return true;
                } else {
                    colourCells();
                    return false;
                }
            }
        }

        if(Character.isDigit(operatorLast)){
            if(Character.getNumericValue(operatorLast)==getTexts().get(0)){
                return true;
            }
        }

        colourCells();
        return false;
    }

    private void colourCells() {
        for(Cell cell : cells) {
            cell.getCell().setId("wrong");
        }
    }

    private void checkBorders(int rowNum){
        for(Cell cell : cells) {
            boolean top = false;
            boolean right = false;
            boolean bottom = false;
            boolean left = false;

            for(Cell cellRef :cells) {
                if(!(cellRef.getNumber()==cell.getNumber())){
                    if(cellRef.getNumber()-cell.getNumber()==1){
                        right = true;
                    }
                    else if(cellRef.getNumber()-cell.getNumber()==-1){
                        left = true;
                    }
                    else if(cellRef.getNumber()+rowNum==cell.getNumber()){
                        top = true;
                    }
                    else if(cellRef.getNumber()-rowNum==cell.getNumber()){
                        bottom = true;
                    }
                }
            }
            setBorders(cell,top,right,bottom,left);
        }
    }

    private void setBorders(Cell cell, boolean top, boolean right, boolean bottom, boolean left) {
        String topColour;
        int topWidth;
        String rightColour;
        int rightWidth;
        String bottomColour;
        int bottomWidth;
        String leftColour;
        int leftWidth;

        if (top) {
            topColour = "lightgrey";
            topWidth = 1;
        } else {
            topColour = "black";
            topWidth = 2;
        }
        if(bottom){
            bottomColour="lightgrey";
            bottomWidth=1;
        } else {
            bottomColour="black";
            bottomWidth=2;
        }
        if(right){
            rightColour="lightgrey";
            rightWidth=1;
        } else {
            rightColour="black";
            rightWidth=2;
        }
        if(left){
            leftColour="lightgrey";
            leftWidth=1;
        } else {
            leftColour="black";
            leftWidth=2;
        }

        cell.getCell().setStyle("-fx-border-width: "+topWidth+" "+rightWidth+" "+bottomWidth+" "+leftWidth+"; -fx-border-color: "+topColour+" "+rightColour+" "+bottomColour+" "+leftColour+";");
    }
}