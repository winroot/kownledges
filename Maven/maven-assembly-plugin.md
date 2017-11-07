# maven-assembly-plugin 入门指南
通过maven assembly-plugin插件打包项目重要有以下两个步骤：

1.**pom.xml文件配置**  
通过maven中的assembly-plugin插件打包首先需要在项目pom.xml或者module中对应的pom.xml文件中添加asseambly-plugin相关配置项：  
 
     <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>3.0.0</version>
                <executions><!--执行器 mvn assembly:assembly--> 
                    <execution>
                        <!-- 名字任意-->
                        <id>make-assembly</id>
                        <!-- maven 生命周期，当执行mvn package时才会打包 --> 
                        <phase>package</phase>
                        <goals>
                            <!-- 只运行一次 --> 
                            <goal>single</goal>
                        </goals>
                        <configuration>
                            <descriptors>
                                <!--描述文件路径-->  
                                <descriptor>src/main/assembly/assembly.xml</descriptor>
                            </descriptors>
                            <!-- 是否在打包出来的文件名中添加 assembly id -->
                            <appendAssemblyId>false</appendAssemblyId>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
    
2. **assembly文件配置**  
上一步只是在pom.xml 文件中指定了maven项目打包所使用到的工具，具体项目如何打包，文件类型、过滤等操作需要在assembly.xml文件中配置。  
1） 首先在 pom.xml 配置项所指定的路径<descriptor>src/main/assembly/assembly.xml</descriptor>下创建assembly.xml文件。  
2） 配置打包项：
<assembly>
    <id>all</id>
    <formats>
        <format>tar.gz</format>
        <format>dir</format>
    </formats>
    <fileSets>
        <!--项目README 文件-->
        <fileSet>
            <directory>../</directory>
            <includes>
                <include>README.md</include>
            </includes>
        </fileSet>
        <!-- Spark_Streming 模块conf文件-->
        <fileSet>
            <directory>../Spark_Streaming/src/main/resources/</directory>
            <includes>
                <include>**</include>
            </includes>
            <excludes>
                <exclude>spring-context.xml</exclude>
            </excludes>
            <outputDirectory>\conf</outputDirectory>
        </fileSet>
        <fileSet>
            <directory>../Spark_Streaming/target/Spark_Streaming</directory>
            <includes>
                <include>**</include>
            </includes>
            <outputDirectory>\Spark_Streaming</outputDirectory>
        </fileSet>
    </fileSets>
</assembly>