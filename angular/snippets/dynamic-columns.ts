private handleColumns(fromCount: number, currentIndex: number, toCount?: number): void {

    const maxCount = this.getMaxToCount(); // add a method to fetch max count value

    if (toCount >= maxCount) {
      return;
    }

    // access the next standard mod price obj based on current index
    const nextColumnObj = this.columnObjects[currentIndex + 1];

    if (!toCount && !nextColumnObj) {
      return;
    }

    // calculate the next from count
    const nextFromCount = toCount + 1;
    
    if (!nextColumnObj) {
      this.addStandardModPrice(nextFromCount, currentIndex, 0);
      return;
    }
    else {
      if (nextColumnObj.FromCnt === toCount + 1) {
        return;
      }
      else {
        this.columnObjects[currentIndex + 1].FromCnt = nextFromCount;

        // call the function recursively to handle the generation of the columns
        const nextnextColumnObj = this.columnObjects[currentIndex + 2];
        const nextToCount = nextnextColumnObj ? nextnextColumnObj.FromCnt - 1 : maxCount;

        // recursive call
        this.handleColumns(nextFromCount, currentIndex + 1, nextToCount);
      }
    }
  }
