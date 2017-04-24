import Coordinate from '../src/coordinate';

describe('coordinate', () => {
    it('should be equal', () => {
        const c1 = new Coordinate(2, 3);
        const c2 = new Coordinate(2, 3);        
        expect(c1).toEqual(c2);
    });

    it('should not be equal because of 1st coordinate', () => {
        const c1 = new Coordinate(2, 3);
        const c2 = new Coordinate(3, 3);        
        expect(c1).not.toEqual(c2);
    });

    it('should not be equal because of 2st coordinate', () => {
        const c1 = new Coordinate(2, 3);
        const c2 = new Coordinate(2, 4);        
        expect(c1).not.toEqual(c2);
    });
});
