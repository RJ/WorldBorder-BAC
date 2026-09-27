import java.nio.file.Files;
import java.nio.file.Path;
import net.minecraft.SharedConstants;
import net.minecraft.commands.Commands;
import net.minecraft.data.registries.VanillaRegistries;
import net.minecraft.server.Bootstrap;
import net.minecraft.server.permissions.PermissionSet;

/** Parses the pack with Minecraft's real command parser, without starting a server. */
public class ValidateFunctions {
    public static void main(String[] args) throws Exception {
        SharedConstants.tryDetectVersion();
        Bootstrap.bootStrap();
        var context = Commands.createValidationContext(VanillaRegistries.createWorldLookup());
        var dispatcher = new Commands(Commands.CommandSelection.ALL, context).getDispatcher();
        var source = Commands.createCompilationContext(PermissionSet.ALL_PERMISSIONS);
        int count = 0;
        int failures = 0;
        try (var files = Files.walk(Path.of(args[0]))) {
            for (var file : files.filter(p -> p.toString().endsWith(".mcfunction")).sorted().toList()) {
                int lineNumber = 0;
                for (var line : Files.readAllLines(file)) {
                    lineNumber++;
                    if (line.isBlank() || line.stripLeading().startsWith("#")) continue;
                    count++;
                    try {
                        Commands.validateParseResults(dispatcher.parse(line, source));
                    } catch (Exception e) {
                        System.err.println(file + ":" + lineNumber + ": " + e.getMessage());
                        failures++;
                    }
                }
            }
        }
        System.out.println("Parsed " + count + " commands; " + failures + " failures.");
        System.exit(failures == 0 ? 0 : 1);
    }
}
