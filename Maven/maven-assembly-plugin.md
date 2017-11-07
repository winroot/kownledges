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
```
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
```
**描述符文件元素**   
id 标识符，添加到生成文件名称的后缀符。如果指定 id 的话，目标文件则是 ${artifactId}-${id}.tar.gz
```
<id>release</id>  
```
**formats**  
maven-assembly-plugin 支持的打包格式有zip、tar、tar.gz (or tgz)、tar.bz2 (or tbz2)、jar、dir、war，可以同时指定多个打包格式
```
  <formats>
    <format>tar.gz</format>
    <format>dir</format>
  </formats>
```
**dependencySets**用来定制工程依赖 jar 包的打包方式，核心元素如下表所示。

|元素	              |类型	           |       作用|
|----------------|------------------:|:---------|
|outputDirectory	   |String	         |        指定包依赖目录，该目录是相对于根目录|
|includes/include*	 |List<String>	   |      包含依赖|
|excludes/exclude*	 |List<String>	    |      排除依赖|
 ```
<dependencySets>
    <dependencySet>
      <outputDirectory>/lib</outputDirectory>
    </dependencySet>
  </dependencySets>
```
 
 **fileSets**管理一组文件的存放位置，核心元素如下表所示。

|元素	|类型|	作用|
|----|----:|:---|
|outputDirectory	|String	|指定文件集合的输出目录，该目录是相对于根目录|
|includes/include*	|List<String>	|包含文件|
|excludes/exclude*	|List<String>	|排除文件|
|fileMode	|String	|指定文件属性，使用八进制表达，分别为(User)(Group)(Other)所属属性，默认为 0644|
  ```<fileSets>
    <fileSet>
      <includes>
        <include>bin/**</include>
      </includes>
      <fileMode>0755</fileMode>
    </fileSet>
    <fileSet>
      <includes>
        <include>/conf/**</include>
        <include>logs</include>
      </includes>
    </fileSet>
  </fileSets>
  ```
 
**files** 可以指定目的文件名到指定目录，其他和 fileSets 相同，核心元素如下表所示。

|元素|	类型	|作用|
|---|----:|:---:|
|source	|String	|源文件，相对路径或绝对路径|
|outputDirectory	|String	|输出目录|
|destName	|String	|目标文件名|
|fileMode	|String	|设置文件 UNIX 属性|
 ```
 <files>
    <file>
      <source>README.txt</source>
      <outputDirectory>/</outputDirectory>
    </file>
  </files>
  ```

