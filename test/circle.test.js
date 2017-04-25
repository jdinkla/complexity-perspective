import Circle from '../src/circle';
import Vector from '../src/vector';

describe('Circle', () => {
  it('should be equal', () => {
    const c1 = new Circle('red', 3.3, new Vector(2, 3), new Vector(4, 5));
    const c2 = new Circle('red', 3.3, new Vector(2, 3), new Vector(4, 5));
    expect(c1).toEqual(c2);
  });

  it('should not be equal because of 1st coordinate', () => {
    const c1 = new Circle('red', 3.3, new Vector(2, 3), new Vector(4, 5));
    const c2 = new Circle('red', 3.3, new Vector(2, 3));
    expect(c1).not.toEqual(c2);
  });

  it('step should calculate next position', () => {
    const c1 = new Circle('red', 3.3, new Vector(0, 0), new Vector(1.0, 1.0));
    expect(c1.position).toEqual(new Vector(0, 0));
    c1.step();
    expect(c1.position).toEqual(new Vector(1, 1));
    c1.step();
    expect(c1.position).toEqual(new Vector(2, 2));
  });
});
