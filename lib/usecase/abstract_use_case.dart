abstract class AbstractUseCase<INPUT, OUTPUT> {
  Future<OUTPUT> execute(INPUT input);
}
