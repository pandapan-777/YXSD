import { TaskList } from './TaskList';
import { TaskTabs } from './TaskTabs';

@Entry
@Component
export struct Task {
  @State message: string = 'Hello World';

  build() {
    Column() {
      TaskTabs()

    }
    .height('100%')
    .width('100%')
  }
}